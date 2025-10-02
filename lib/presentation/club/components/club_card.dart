import 'dart:convert';
import 'package:biboo_pro/presentation/club/components/ClubData.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClubsGridView extends StatefulWidget {
  final String category;
  final String? dateFilter;
  final String? searchQuery;
  final String? instructor;
  final String? priceRange;

  const ClubsGridView({
    Key? key,
    required this.category,
    this.dateFilter,
    this.searchQuery,
    this.instructor,
    this.priceRange,
  }) : super(key: key);

  @override
  ClubsGridViewState createState() => ClubsGridViewState();
}

class ClubsGridViewState extends State<ClubsGridView> with AutomaticKeepAliveClientMixin {
  List<ClubDataEntity> allClubs = [];
  List<ClubDataEntity> filteredClubs = [];
  List<String> cancelledClubIds = [];
  bool isLoading = true;
  String? currentDateFilter;
  String currentSearchQuery = '';
  String? currentInstructor;
  String? currentPriceRange;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    currentDateFilter = widget.dateFilter;
    currentSearchQuery = widget.searchQuery ?? '';
    currentInstructor = widget.instructor;
    currentPriceRange = widget.priceRange;
    _loadClubs();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupPeriodicRefresh();
    });
  }

  void updateFilters(String? dateFilter, String searchQuery, String? instructor, String? priceRange) {
    setState(() {
      currentDateFilter = dateFilter;
      currentSearchQuery = searchQuery;
      currentInstructor = instructor;
      currentPriceRange = priceRange;
    });
    _applyAllFilters();
  }

  void _setupPeriodicRefresh() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _loadClubs();
        _setupPeriodicRefresh();
      }
    });
  }

  @override
  void didUpdateWidget(ClubsGridView oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool shouldUpdate = false;
    
    if (oldWidget.category != widget.category ||
        oldWidget.dateFilter != widget.dateFilter ||
        oldWidget.searchQuery != widget.searchQuery ||
        oldWidget.instructor != widget.instructor ||
        oldWidget.priceRange != widget.priceRange) {
      
      currentDateFilter = widget.dateFilter;
      currentSearchQuery = widget.searchQuery ?? '';
      currentInstructor = widget.instructor;
      currentPriceRange = widget.priceRange;
      shouldUpdate = true;
    }
    
    if (shouldUpdate) {
      _applyAllFilters();
    }
  }

  Future<void> _loadClubs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final clubsJson = prefs.getString('clubs');
      final cancelledIds = prefs.getStringList('cancelled_clubs') ?? [];
      
      if (clubsJson != null) {
        final List<dynamic> decodedClubs = json.decode(clubsJson);
        
        final newClubs = decodedClubs
            .map((clubJson) => ClubDataEntity.fromJson(clubJson))
            .toList();
        
        if (mounted) {
          setState(() {
            allClubs = newClubs;
            cancelledClubIds = cancelledIds;
          });
          _applyAllFilters();
        }
      } else {
        if (mounted) {
          setState(() {
            allClubs = [];
            filteredClubs = [];
            cancelledClubIds = cancelledIds;
          });
        }
      }
    } catch (e) {
      print('ClubsGridView: Erreur lors du chargement: $e');
    } finally {
      if (mounted && isLoading) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _applyAllFilters() {
    List<ClubDataEntity> clubs = List.from(allClubs);
    
    // 1. Filtrer par catégorie
    clubs = _filterClubsByCategory(clubs);
    
    // 2. Filtrer par instructeur
    clubs = _filterClubsByInstructor(clubs);
    
    // 3. Filtrer par prix
    clubs = _filterClubsByPrice(clubs);
    
    // 4. Filtrer par recherche
    clubs = _filterClubsBySearch(clubs);
    
    // 5. Trier par date de création (plus récent en premier)
    clubs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    if (mounted) {
      setState(() {
        filteredClubs = clubs;
      });
    }
  }

  List<ClubDataEntity> _filterClubsByCategory(List<ClubDataEntity> clubs) {
    if (widget.category == 'Tous les clubs') {
      return clubs;
    }
    
    return clubs.where((club) {
      String clubType = club.type.toLowerCase();
      String category = widget.category.toLowerCase();
      
      switch (category) {
        case 'sport':
          return clubType.contains('foot') || 
                 clubType.contains('sport') || 
                 clubType.contains('tennis') ||
                 clubType.contains('basket');
        case 'musique':
          return clubType.contains('musique') || 
                 clubType.contains('piano') || 
                 clubType.contains('guitare') ||
                 clubType.contains('chant');
        case 'danse':
          return clubType.contains('danse') || 
                 clubType.contains('ballet') || 
                 clubType.contains('hip hop');
        case 'théâtre':
          return clubType.contains('théâtre') || 
                 clubType.contains('drama') || 
                 clubType.contains('comédie');
        default:
          return true;
      }
    }).toList();
  }

  List<ClubDataEntity> _filterClubsByInstructor(List<ClubDataEntity> clubs) {
    if (currentInstructor == null || currentInstructor!.isEmpty) {
      return clubs;
    }
    
    return clubs.where((club) => 
        club.instructor.toLowerCase().contains(currentInstructor!.toLowerCase())
    ).toList();
  }

  List<ClubDataEntity> _filterClubsByPrice(List<ClubDataEntity> clubs) {
    if (currentPriceRange == null || currentPriceRange!.isEmpty) {
      return clubs;
    }
    
    return clubs.where((club) {
      if (currentPriceRange == 'Gratuit') {
        return !club.isPaid;
      } else if (currentPriceRange == 'Payant') {
        return club.isPaid;
      }
      return true;
    }).toList();
  }

  List<ClubDataEntity> _filterClubsBySearch(List<ClubDataEntity> clubs) {
    if (currentSearchQuery.isEmpty) {
      return clubs;
    }
    
    final query = currentSearchQuery.toLowerCase();
    
    return clubs.where((club) {
      final type = club.type.toLowerCase();
      final description = club.description.toLowerCase();
      final instructor = club.instructor.toLowerCase();
      
      return type.contains(query) ||
             description.contains(query) ||
             instructor.contains(query);
    }).toList();
  }

  List<String> _getScheduleList(ClubDataEntity club) {
    // Priorité aux daySchedules s'il y en a plusieurs
    if (club.daySchedules != null && club.daySchedules!.isNotEmpty) {
      return club.daySchedules!.map((daySchedule) {
        final day = daySchedule['day'] as String?;
        final startTimeMap = daySchedule['startTime'] as Map<String, dynamic>?;
        final endTimeMap = daySchedule['endTime'] as Map<String, dynamic>?;
        
        if (day != null && startTimeMap != null && endTimeMap != null) {
          final startTime = TimeOfDay(
            hour: startTimeMap['hour'] as int, 
            minute: startTimeMap['minute'] as int
          );
          final endTime = TimeOfDay(
            hour: endTimeMap['hour'] as int, 
            minute: endTimeMap['minute'] as int
          );
          
          return '$day: ${startTime.format(context)} - ${endTime.format(context)}';
        }
        return '$day: Horaire non défini';
      }).toList();
    }
    
    // Fallback vers schedule existant
    if (club.schedule != null && club.schedule!.isNotEmpty) {
      return club.schedule!;
    }
    
    // Fallback vers selectedDay
    if (club.selectedDay != null && club.startTime != null && club.endTime != null) {
      return ['${club.selectedDay}: ${club.startTime!.format(context)} - ${club.endTime!.format(context)}'];
    }
    
    return ['Horaire non défini'];
  }

  String _getPeriodText(ClubDataEntity club) {
    if (club.periodInMonths != null && club.periodInMonths! > 0) {
      return club.periodInMonths == 1 
          ? '1 mois' 
          : '${club.periodInMonths} mois';
    }
    return 'Période non définie';
  }

  Future<void> refreshClubs() async {
    await _loadClubs();
  }

  Future<void> _handleCancelClub(ClubDataEntity club) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      if (!cancelledClubIds.contains(club.id)) {
        cancelledClubIds.add(club.id);
        await prefs.setStringList('cancelled_clubs', cancelledClubIds);
        
        _applyAllFilters();
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print('Erreur lors de l\'annulation du club: $e');
    }
  }

  Future<void> _handleDeleteClub(ClubDataEntity club) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      allClubs.removeWhere((c) => c.id == club.id);
      cancelledClubIds.remove(club.id);
      final clubsJson = json.encode(allClubs.map((c) => c.toJson()).toList());
      await prefs.setString('clubs', clubsJson);
      await prefs.setStringList('cancelled_clubs', cancelledClubIds);
      
      _applyAllFilters();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Erreur lors de la suppression du club: $e');
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

    if (filteredClubs.isEmpty) {
      String emptyMessage = 'Aucun club';
      
      if (currentSearchQuery.isNotEmpty) {
        emptyMessage = 'Aucun résultat pour "${currentSearchQuery}"';
      } else if (widget.category != 'Tous les clubs') {
        emptyMessage = 'Aucun club ${widget.category.toLowerCase()}';
      } else {
        emptyMessage = 'Aucun club créé';
      }
      
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.groups,
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
            if (currentSearchQuery.isNotEmpty) ...[
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
                'Les clubs apparaîtront ici une fois créés',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: refreshClubs,
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
          itemCount: filteredClubs.length,
          itemBuilder: (context, index) {
            final club = filteredClubs[index];
            return ClubCard(
              title: club.type,
              imageUrl: club.imagePath ?? 'assets/images/default_club.png',
              instructor: club.instructor,
              price: club.isPaid ? '${club.price} TND' : 'Gratuit',
              capacity: '${club.capacity} enfants',
              description: club.description,
              schedule: _getScheduleList(club),
              period: _getPeriodText(club),
              classeConcernee: club.classeConcernee,
              adresse: club.adresse,
              cardWidth: cardWidth,
              cardHeight: cardHeight,
              club: club,
              onCancel: _handleCancelClub,
              onDelete: _handleDeleteClub,
              isCancelled: cancelledClubIds.contains(club.id),
            );
          },
        ),
      ),
    );
  }
}

// Widget ClubCard corrigé pour éviter l'overflow
class ClubCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String instructor;
  final String price;
  final String capacity;
  final String description;
  final List<String> schedule;
  final String period;
  final String? classeConcernee;
  final String? adresse;
  final double cardWidth;
  final double cardHeight;
  final ClubDataEntity club;
  final Function(ClubDataEntity) onCancel;
  final Function(ClubDataEntity) onDelete;
  final bool isCancelled;

  const ClubCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.instructor,
    required this.price,
    required this.capacity,
    required this.description,
    required this.schedule,
    required this.period,
    this.classeConcernee,
    this.adresse,
    required this.cardWidth,
    required this.cardHeight,
    required this.club,
    required this.onCancel,
    required this.onDelete,
    required this.isCancelled,
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
                  "Annuler ce club",
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
                    onCancel(club);
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
                  "Supprimer ce club",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    color: Color(0xFF303972),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Cette action est irréversible. Êtes-vous sûr de vouloir supprimer ce club ?",
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
                  onDelete(club);
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
            // Header avec statut et menu trois points
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isCancelled ? Colors.red : Colors.green,
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
                        isCancelled ? 'Annulé' : 'Actif',
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
                      Icons.groups,
                      size: 48,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildInfoRow(
                      icon: Icons.person,
                      color: Colors.blueAccent,
                      text: instructor,
                    ),
                    const SizedBox(height: 4),
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
                            icon: Icons.child_care,
                            color: Colors.orange,
                            text: capacity,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _IconInSquare(
                          icon: Icons.calendar_today,
                          color: Colors.purple,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: schedule.take(2).map((day) => Text(
                              day,
                              style: const TextStyle(fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            )).toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    
                    // Période
                    _buildInfoRow(
                      icon: Icons.access_time,
                      color: Colors.teal,
                      text: 'Période: $period',
                      fontSize: 13,
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