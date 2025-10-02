import 'dart:convert';

import 'package:biboo_pro/presentation/events/components/EventData.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/components/summary_section.dart';
import '../../../core/constants/colors.dart';
import '../../../core/shared/entities/Event.dart';
import '../../../core/shared/entities/summaryItem.dart';
import 'ajouter_event.dart';
import 'events_card.dart';

class EventsPage extends StatefulWidget {
  final VoidCallback? onAddPressed;

  const EventsPage({super.key, this.onAddPressed});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  // Variables pour le filtrage
  String? selectedDateFilter;
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  // Variables pour les statistiques dynamiques
  int totalParticipants = 0;
  int totalEvents = 0;
  int completedEvents = 0;
  int upcomingEvents = 0;

  // GlobalKeys pour accéder aux EventGridView
  final GlobalKey<EventGridViewState> allEventsKey = GlobalKey();
  final GlobalKey<EventGridViewState> terminatedEventsKey = GlobalKey();
  final GlobalKey<EventGridViewState> inProgressEventsKey = GlobalKey();
  final GlobalKey<EventGridViewState> upcomingEventsKey = GlobalKey();
  final GlobalKey<EventGridViewState> cancelledEventsKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Méthode pour charger les statistiques depuis SharedPreferences
  Future<void> _loadStatistics() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final eventsJson = prefs.getString('events');
      final cancelledIds = prefs.getStringList('cancelled_events') ?? [];
      
      if (eventsJson != null) {
        final List<dynamic> decodedEvents = json.decode(eventsJson);
        final events = decodedEvents
            .map((eventJson) => EventDataEntity.fromJson(eventJson))
            .toList();
        
        _calculateStatistics(events, cancelledIds);
      } else {
        _calculateStatistics([], cancelledIds);
      }
    } catch (e) {
      print('Erreur lors du chargement des statistiques: $e');
      _calculateStatistics([], []);
    }
  }

  void _calculateStatistics(List<EventDataEntity> events, List<String> cancelledIds) {
    final now = DateTime.now();
    
    // Exclure les événements annulés des calculs
    final activeEvents = events.where((event) => !cancelledIds.contains(event.id)).toList();
    
    int participants = 0;
    int completed = 0;
    int upcoming = 0;
    
    for (var event in activeEvents) {
      // Calculer les participants (vous pouvez ajuster selon votre modèle)
      // participants += event.participantsCount ?? 0;
      
      // Calculer les statuts
      if (event.date.isBefore(now)) {
        completed++;
      } else {
        upcoming++;
      }
    }
    
    setState(() {
      totalEvents = activeEvents.length;
      totalParticipants = participants; // ou une valeur calculée selon vos besoins
      completedEvents = completed;
      upcomingEvents = upcoming;
    });
  }

  void _clearFilters() {
    setState(() {
      selectedDateFilter = null;
      searchQuery = '';
      searchController.clear();
    });
    _notifyAllGridViews();
  }

  void _notifyAllGridViews() {
    // Notifier tous les EventGridView des changements de filtres
    allEventsKey.currentState?.updateFilters(selectedDateFilter, searchQuery);
    terminatedEventsKey.currentState?.updateFilters(selectedDateFilter, searchQuery);
    inProgressEventsKey.currentState?.updateFilters(selectedDateFilter, searchQuery);
    upcomingEventsKey.currentState?.updateFilters(selectedDateFilter, searchQuery);
    cancelledEventsKey.currentState?.updateFilters(selectedDateFilter, searchQuery);
  }

  // Méthode pour rafraîchir les statistiques quand les données changent
  void _refreshStatistics() {
    _loadStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SummarySection(
            items: [
              SummaryItem(
                  label: 'Participants',
                  value: totalParticipants,
                  icon: Iconsax.people,
                  color: Colors.blue),
              SummaryItem(
                  label: 'Événements',
                  value: totalEvents,
                  icon: Iconsax.calendar,
                  color: Colors.red),
              SummaryItem(
                  label: 'Événements terminés',
                  value: completedEvents,
                  icon: Iconsax.calendar_tick,
                  color: Colors.green),
              SummaryItem(
                  label: 'Événements à venir',
                  value: upcomingEvents,
                  icon: Icons.upcoming,
                  color: Colors.orange),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Aperçu des événements",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: bGris10,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          print("Ajouter un événement");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventFormScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text("Ajouter Event"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: bSecondaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 5,
                    child: Column(
                      children: [
                        TabBar(
                          tabs: const [
                            Tab(text: 'Tous les events'),
                            Tab(text: "Terminés"),
                            Tab(text: "En cours"),
                            Tab(text: "À venir"),
                            Tab(text: "Annulés"),
                          ],
                          labelColor: bPrimaryColor,
                          unselectedLabelColor: bGris10,
                          indicatorColor: bPrimaryColor,
                          isScrollable: true,
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              // Tous les événements avec filtres
                              _buildEventsTabWithFilters("tous", allEventsKey),
                              _buildEventsTab("terminé", terminatedEventsKey),
                              _buildEventsTab("en cours", inProgressEventsKey),
                              _buildEventsTab("à venir", upcomingEventsKey),
                              _buildEventsTab("annuler", cancelledEventsKey),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsTabWithFilters(String status, GlobalKey<EventGridViewState> key) {
    return Column(
      children: [
        // Barre de filtres et recherche
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Filtre par date
              Container(
                width: 160,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    const Icon(Icons.timer, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: const SizedBox(),
                        value: selectedDateFilter,
                        hint: const Text(
                          'Filtrer par date',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        items: [
                          'Aujourd\'hui',
                          'Cette semaine',
                          'Ce mois',
                          'Cette année',
                          'Toutes'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value == 'Toutes' ? null : value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDateFilter = value;
                          });
                          _notifyAllGridViews();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Spacer(),
              // Barre de recherche
              Expanded(
                flex: 2,
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                    _notifyAllGridViews();
                  },
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Rechercher...',
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: bGris9,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: bGris9, width: 2),
                    ),
                  ),
                ),
              ),
              // Bouton pour effacer les filtres
              if (selectedDateFilter != null || searchQuery.isNotEmpty)
                IconButton(
                  onPressed: _clearFilters,
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  tooltip: 'Effacer les filtres',
                ),
            ],
          ),
        ),
        // Liste des événements
        Expanded(
          child: EventGridView(
            key: key,
            status: status,
            dateFilter: selectedDateFilter,
            searchQuery: searchQuery,
          ),
        ),
      ],
    );
  }

  Widget _buildEventsTab(String status, GlobalKey<EventGridViewState> key) {
    return EventGridView(
      key: key,
      status: status,
      dateFilter: selectedDateFilter,
      searchQuery: searchQuery,
    );
  }
}