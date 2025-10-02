import 'dart:convert';
import 'package:biboo_pro/presentation/events/components/EventData.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventGridView extends StatefulWidget {
  final String status;
  final String? dateFilter;
  final String? searchQuery;

  const EventGridView({
    Key? key,
    required this.status,
    this.dateFilter,
    this.searchQuery,
  }) : super(key: key);

  @override
  EventGridViewState createState() => EventGridViewState();
}

class EventGridViewState extends State<EventGridView> with AutomaticKeepAliveClientMixin {
  List<EventDataEntity> allEvents = [];
  List<EventDataEntity> filteredEvents = [];
  List<String> cancelledEventIds = [];
  bool isLoading = true;
  String? currentDateFilter;
  String currentSearchQuery = '';

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    currentDateFilter = widget.dateFilter;
    currentSearchQuery = widget.searchQuery ?? '';
    _loadEvents();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupPeriodicRefresh();
    });
  }

  void updateFilters(String? dateFilter, String searchQuery) {
    setState(() {
      currentDateFilter = dateFilter;
      currentSearchQuery = searchQuery;
    });
    _applyAllFilters();
  }

  void _setupPeriodicRefresh() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _loadEvents();
        _setupPeriodicRefresh();
      }
    });
  }

  @override
  void didUpdateWidget(EventGridView oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool shouldUpdate = false;
    
    if (oldWidget.status != widget.status) {
      shouldUpdate = true;
    }
    
    if (oldWidget.dateFilter != widget.dateFilter) {
      currentDateFilter = widget.dateFilter;
      shouldUpdate = true;
    }
    
    if (oldWidget.searchQuery != widget.searchQuery) {
      currentSearchQuery = widget.searchQuery ?? '';
      shouldUpdate = true;
    }
    
    if (shouldUpdate) {
      _applyAllFilters();
    }
  }

  Future<void> _loadEvents() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final eventsJson = prefs.getString('events');
      final cancelledIds = prefs.getStringList('cancelled_events') ?? [];
      
      if (eventsJson != null) {
        final List<dynamic> decodedEvents = json.decode(eventsJson);
        
        final newEvents = decodedEvents
            .map((eventJson) => EventDataEntity.fromJson(eventJson))
            .toList();
        
        if (mounted) {
          setState(() {
            allEvents = newEvents;
            cancelledEventIds = cancelledIds;
          });
          _applyAllFilters();
        }
      } else {
        if (mounted) {
          setState(() {
            allEvents = [];
            filteredEvents = [];
            cancelledEventIds = cancelledIds;
          });
        }
      }
    } catch (e) {
      print('EventGridView: Erreur lors du chargement: $e');
    } finally {
      if (mounted && isLoading) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _applyAllFilters() {
    List<EventDataEntity> events = List.from(allEvents);
    
    // 1. Filtrer par statut
    events = _filterEventsByStatus(events);
    
    // 2. Filtrer par date
    events = _filterEventsByDate(events);
    
    // 3. Filtrer par recherche
    events = _filterEventsBySearch(events);
    
    // 4. Trier par date de création (plus récent en premier)
    events.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    if (mounted) {
      setState(() {
        filteredEvents = events;
      });
    }
  }

  List<EventDataEntity> _filterEventsByStatus(List<EventDataEntity> events) {
    final now = DateTime.now();
    
    switch (widget.status.toLowerCase()) {
      case 'tous':
        return events;
      case 'terminé':
        return events.where((event) => event.date.isBefore(now)).toList();
      case 'en cours':
        return events.where((event) {
          final eventDate = event.date;
          final today = DateTime(now.year, now.month, now.day);
          final eventDay = DateTime(eventDate.year, eventDate.month, eventDate.day);
          return eventDay.isAtSameTime(today);
        }).toList();
      case 'à venir':
        return events.where((event) => event.date.isAfter(now)).toList();
      case 'annuler':
        return events.where((event) => cancelledEventIds.contains(event.id)).toList();
      default:
        return events;
    }
  }

  List<EventDataEntity> _filterEventsByDate(List<EventDataEntity> events) {
    if (currentDateFilter == null || currentDateFilter!.isEmpty) {
      return events;
    }
    
    final now = DateTime.now();
    DateTime startDate;
    DateTime endDate;

    switch (currentDateFilter) {
      case 'Aujourd\'hui':
        startDate = DateTime(now.year, now.month, now.day);
        endDate = startDate.add(const Duration(days: 1));
        break;
      case 'Cette semaine':
        final daysFromMonday = now.weekday - 1;
        startDate = now.subtract(Duration(days: daysFromMonday));
        startDate = DateTime(startDate.year, startDate.month, startDate.day);
        endDate = startDate.add(const Duration(days: 7));
        break;
      case 'Ce mois':
        startDate = DateTime(now.year, now.month, 1);
        endDate = DateTime(now.year, now.month + 1, 1);
        break;
      case 'Cette année':
        startDate = DateTime(now.year, 1, 1);
        endDate = DateTime(now.year + 1, 1, 1);
        break;
      default:
        return events;
    }

    return events.where((event) {
      final eventDate = event.date;
      final eventDay = DateTime(eventDate.year, eventDate.month, eventDate.day);
      return (eventDay.isAfter(startDate) || eventDay.isAtSameMomentAs(startDate)) &&
             eventDay.isBefore(endDate);
    }).toList();
  }

  List<EventDataEntity> _filterEventsBySearch(List<EventDataEntity> events) {
    if (currentSearchQuery.isEmpty) {
      return events;
    }
    
    final query = currentSearchQuery.toLowerCase();
    
    return events.where((event) {
      final title = event.type?.toLowerCase() ?? '';
      final description = event.description.toLowerCase();
      final address = event.Addresse?.toLowerCase() ?? '';
      final category = event.category?.toLowerCase() ?? '';
      final classe = event.classeConcernee?.toLowerCase() ?? '';
      
      return title.contains(query) ||
             description.contains(query) ||
             address.contains(query) ||
             category.contains(query) ||
             classe.contains(query);
    }).toList();
  }

  Color _getStatusColor(EventDataEntity event) {
    if (cancelledEventIds.contains(event.id)) {
      return Colors.red; 
    }
    
    final now = DateTime.now();
    
    if (event.date.isBefore(now)) {
      return Colors.grey; 
    } else {
      final today = DateTime(now.year, now.month, now.day);
      final eventDay = DateTime(event.date.year, event.date.month, event.date.day);
      if (eventDay.isAtSameTime(today)) {
        return Colors.orange; 
      } else {
        return Colors.green; 
      }
    }
  }

  String _getStatusText(EventDataEntity event) {
    if (cancelledEventIds.contains(event.id)) {
      return 'Annulé';
    }
    
    final now = DateTime.now();
    
    if (event.date.isBefore(now)) {
      return 'Terminé';
    } else {
      final today = DateTime(now.year, now.month, now.day);
      final eventDay = DateTime(event.date.year, event.date.month, event.date.day);
      if (eventDay.isAtSameTime(today)) {
        return 'En cours';
      } else {
        return 'Actif';
      }
    }
  }

  String _formatDuration(EventDataEntity event) {
    if (event.startTime == null || event.endTime == null) {
      return "Durée non définie";
    }

    int startMinutes = event.startTime!.hour * 60 + event.startTime!.minute;
    int endMinutes = event.endTime!.hour * 60 + event.endTime!.minute;

    if (endMinutes < startMinutes) {
      endMinutes += 24 * 60;
    }

    int durationMinutes = endMinutes - startMinutes;
    
    if (durationMinutes <= 0) {
      return "Durée invalide";
    }

    int hours = durationMinutes ~/ 60;
    int minutes = durationMinutes % 60;

    if (hours == 0) {
      return "${minutes}min";
    } else if (minutes == 0) {
      return "${hours}h";
    } else {
      return "${hours}h ${minutes}min";
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  Future<void> refreshEvents() async {
    await _loadEvents();
  }

  Future<void> _handleCancelEvent(EventDataEntity event) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      if (!cancelledEventIds.contains(event.id)) {
        cancelledEventIds.add(event.id);
        await prefs.setStringList('cancelled_events', cancelledEventIds);
        
        _applyAllFilters();
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print('Erreur lors de l\'annulation de l\'événement: $e');
    }
  }

  Future<void> _handleDeleteEvent(EventDataEntity event) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      allEvents.removeWhere((e) => e.id == event.id);
      cancelledEventIds.remove(event.id);
      final eventsJson = json.encode(allEvents.map((e) => e.toJson()).toList());
      await prefs.setString('events', eventsJson);
      await prefs.setStringList('cancelled_events', cancelledEventIds);
      
      _applyAllFilters();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Erreur lors de la suppression de l\'événement: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (filteredEvents.isEmpty) {
      String emptyMessage = 'Aucun événement';
      
      if (currentSearchQuery.isNotEmpty) {
        emptyMessage = 'Aucun résultat pour "${currentSearchQuery}"';
      } else if (currentDateFilter != null) {
        emptyMessage = 'Aucun événement pour ${currentDateFilter?.toLowerCase()}';
      } else {
        emptyMessage = 'Aucun événement ${widget.status.toLowerCase()}';
      }
      
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_note,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            if (currentSearchQuery.isNotEmpty || currentDateFilter != null) ...[
              Text(
                'Essayez de modifier vos critères de recherche',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ] else ...[
              Text(
                'Les événements apparaîtront ici une fois créés',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: refreshEvents,
              icon: const Icon(Icons.refresh),
              label: const Text('Actualiser'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = 380;
    double cardHeight = 420; 

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenWidth > 1350 ? 4 : 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
          itemCount: filteredEvents.length,
          itemBuilder: (context, index) {
            final event = filteredEvents[index];
            return EventCard(
              title: event.type ?? 'Événement sans titre',
              imageUrl: event.imagePath ?? 'assets/images/default_event.png',
              date: _formatDate(event.date),
              time: event.startTime != null && event.endTime != null
                  ? '${event.startTime!.format(context)} - ${event.endTime!.format(context)}'
                  : 'Horaire non défini',
              duration: _formatDuration(event),
              price: event.isEventPaid ? '${event.price} TND' : 'Gratuit',
              description: event.description,
              participation: event.participationType ? 'Avec parent' : 'Sans parent',
              classeConcernee: event.classeConcernee,
              adresse: event.Addresse,
              cardWidth: cardWidth,
              cardHeight: cardHeight,
              event: event,
              onCancel: _handleCancelEvent,
              onDelete: _handleDeleteEvent,
              isCancelled: cancelledEventIds.contains(event.id),
              statusColor: _getStatusColor(event),
              statusText: _getStatusText(event),
            );
          },
        ),
      ),
    );
  }
}

// EventCard avec le même design que ClubCard
class EventCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String date;
  final String time;
  final String duration;
  final String price;
  final String description;
  final String participation;
  final String? classeConcernee;
  final String? adresse;
  final double cardWidth;
  final double cardHeight;
  final EventDataEntity event;
  final Function(EventDataEntity) onCancel;
  final Function(EventDataEntity) onDelete;
  final bool isCancelled;
  final Color statusColor;
  final String statusText;

  const EventCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.time,
    required this.duration,
    required this.price,
    required this.description,
    required this.participation,
    this.classeConcernee,
    this.adresse,
    required this.cardWidth,
    required this.cardHeight,
    required this.event,
    required this.onCancel,
    required this.onDelete,
    required this.isCancelled,
    required this.statusColor,
    required this.statusText,
  }) : super(key: key);

  Future<void> _showCancelDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        String email = '';
        String password = '';
        
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.orange.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.cancel_outlined,
                    size: 80,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Annuler cet événement",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    color: Color(0xFF303972),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 500,
                  child: TextField(
                    onChanged: (value) => email = value,
                    decoration: InputDecoration(
                      hintText: "Entrez votre email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        gapPadding: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Color(0xFF70C4CF), width: 2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 500,
                  child: TextField(
                    obscureText: true,
                    onChanged: (value) => password = value,
                    decoration: InputDecoration(
                      hintText: "Entrez votre mot de passe",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        gapPadding: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Color(0xFF70C4CF), width: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(150, 48),
                side: const BorderSide(color: Color(0xFFA098AE), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                "Annuler",
                style: TextStyle(color: Color(0xFFA098AE)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (email.isNotEmpty && password.isNotEmpty) {
                    Navigator.of(context).pop();
                    onCancel(event);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Veuillez remplir tous les champs'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(150, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  "Confirmer",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.red.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    size: 80,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Supprimer cet événement",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    color: Color(0xFF303972),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Cette action est irréversible. Êtes-vous sûr de vouloir supprimer cet événement ?",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(150, 48),
                side: const BorderSide(color: Color(0xFFA098AE), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                "Annuler",
                style: TextStyle(color: Color(0xFFA098AE)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onDelete(event);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(150, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  "Supprimer",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      constraints: BoxConstraints(
        minHeight: cardHeight,
        maxHeight: cardHeight + 50, 
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header avec statut et menu trois points (identique à ClubCard)
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        statusText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.grey[500],
                    size: 18,
                  ),
                  onSelected: (value) {
                    if (value == 'annuler') {
                      _showCancelDialog(context);
                    } else if (value == 'supprimer') {
                      _showDeleteDialog(context);
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    if (!isCancelled)
                      const PopupMenuItem<String>(
                        value: 'annuler',
                        child: Row(
                          children: [
                            Icon(Icons.cancel, color: Colors.orange),
                            SizedBox(width: 8),
                            Text('Annuler'),
                          ],
                        ),
                      ),
                    const PopupMenuItem<String>(
                      value: 'supprimer',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Supprimer'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Image (identique à ClubCard)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageUrl,
                height: 120, 
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.event,
                      size: 48,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            // Titre (identique à ClubCard)
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // Description (identique à ClubCard)
            Text(
              description,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            // Contenu principal adapté aux événements
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Date
                    _buildInfoRow(
                      icon: Icons.calendar_today,
                      color: Colors.blueAccent,
                      text: date,
                    ),
                    const SizedBox(height: 4),
                    // Horaire et durée
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoRow(
                            icon: Icons.access_time,
                            color: Colors.green,
                            text: time,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildInfoRow(
                            icon: Icons.timer,
                            color: Colors.orange,
                            text: duration,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Prix et participation
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoRow(
                            icon: Icons.attach_money,
                            color: Colors.green,
                            text: price,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildInfoRow(
                            icon: Icons.family_restroom,
                            color: Colors.purple,
                            text: participation,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    
                    // Classe concernée
                    if (classeConcernee != null && classeConcernee!.isNotEmpty)
                      Column(
                        children: [
                          _buildInfoRow(
                            icon: Icons.school,
                            color: Colors.indigo,
                            text: 'Classe: $classeConcernee',
                            fontSize: 13,
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    
                    // Adresse
                    if (adresse != null && adresse!.isNotEmpty)
                      _buildInfoRow(
                        icon: Icons.location_on,
                        color: Colors.red,
                        text: 'Lieu: $adresse',
                        fontSize: 13,
                        maxLines: 2,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color color,
    required String text,
    double fontSize = 14,
    int maxLines = 1,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _IconInSquare(icon: icon, color: color, size: 16),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize),
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines,
          ),
        ),
      ],
    );
  }

  Widget _IconInSquare({
    required IconData icon,
    required Color color,
    required double size,
  }) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, color: color, size: size),
    );
  }
}

extension DateTimeExtension on DateTime {
  bool isAtSameTime(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}