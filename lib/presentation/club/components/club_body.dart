import 'dart:convert';
import 'package:biboo_pro/presentation/club/components/club_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/components/summary_section.dart';
import '../../../core/constants/colors.dart';
import '../../../core/shared/entities/summaryItem.dart';
import 'ClubData.dart';

class ClubsBody extends StatefulWidget {
  final VoidCallback onAddPressed;
  final VoidCallback onItemPressed;
  const ClubsBody({super.key, required this.onAddPressed, required this.onItemPressed});

  @override
  State<ClubsBody> createState() => _ClubsBodyState();
}

class _ClubsBodyState extends State<ClubsBody> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  
  // Variables pour les filtres
  String? _selectedDate;
  String? _selectedClub;
  String? _selectedPrice;
  String? _selectedInstructor;
  String _searchQuery = '';
  int _currentTabIndex = 0;
  bool _disposed = false;

  // Variables pour les données dynamiques
  List<ClubDataEntity> allClubs = [];
  List<String> availableInstructors = [];
  List<String> availableClubs = [];
  int totalMembers = 0;
  int totalInstructors = 0;
  int totalTournaments = 0;
  int totalEquipment = 0;

  // Référence aux ClubsGridView pour les notifications de mise à jour
  final GlobalKey<ClubsGridViewState> _allClubsKey = GlobalKey<ClubsGridViewState>();
  final GlobalKey<ClubsGridViewState> _sportKey = GlobalKey<ClubsGridViewState>();
  final GlobalKey<ClubsGridViewState> _musicKey = GlobalKey<ClubsGridViewState>();
  final GlobalKey<ClubsGridViewState> _danceKey = GlobalKey<ClubsGridViewState>();
  final GlobalKey<ClubsGridViewState> _theatreKey = GlobalKey<ClubsGridViewState>();
  final GlobalKey<ClubsGridViewState> _othersKey = GlobalKey<ClubsGridViewState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(_onTabChanged);
    _searchController.addListener(_onSearchChanged);
    _loadClubsData();
    
    // Actualisation périodique
    _setupPeriodicRefresh();
  }

  @override
  void dispose() {
    _disposed = true;
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _setupPeriodicRefresh() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && !_disposed) {
        _loadClubsData();
        _setupPeriodicRefresh();
      }
    });
  }

  void _onTabChanged() {
    if (!_disposed && mounted) {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
      _updateCurrentGridView();
    }
  }

  void _onSearchChanged() {
    if (!_disposed && mounted) {
      setState(() {
        _searchQuery = _searchController.text;
      });
      _updateCurrentGridView();
    }
  }

  // Chargement des données depuis le storage
  Future<void> _loadClubsData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final clubsJson = prefs.getString('clubs');
      
      if (clubsJson != null) {
        final List<dynamic> decodedClubs = json.decode(clubsJson);
        final loadedClubs = decodedClubs
            .map((clubJson) => ClubDataEntity.fromJson(clubJson))
            .toList();
        
        if (mounted) {
          setState(() {
            allClubs = loadedClubs;
            _updateDerivedData();
          });
        }
      }
    } catch (e) {
      print('Erreur lors du chargement des clubs: $e');
    }
  }

  // Mise à jour des données dérivées (instructeurs, statistiques, etc.)
  void _updateDerivedData() {
    // Extraction des instructeurs uniques
    availableInstructors = allClubs
        .map((club) => club.instructor)
        .toSet()
        .toList();
    availableInstructors.sort();

    // Extraction des noms de clubs uniques
    availableClubs = allClubs
        .map((club) => club.type)
        .toSet()
        .toList();
    availableClubs.sort();

    // Calcul des statistiques (vous pouvez adapter selon vos besoins)
    totalMembers = allClubs.fold(0, (sum, club) => sum + club.capacity);
    totalInstructors = availableInstructors.length;
    totalTournaments = 10; // Valeur statique ou calculée selon votre logique
    totalEquipment = 50; // Valeur statique ou calculée selon votre logique
  }

  // Mise à jour du GridView actuel avec les nouveaux filtres
  void _updateCurrentGridView() {
    ClubsGridViewState? currentGridState = _getCurrentGridState();
    currentGridState?.updateFilters(
      _selectedDate,
      _searchQuery,
      _selectedInstructor,
      _selectedPrice,
    );
  }

  // Récupération de l'état du GridView actuel
  ClubsGridViewState? _getCurrentGridState() {
    switch (_currentTabIndex) {
      case 0: return _allClubsKey.currentState;
      case 1: return _sportKey.currentState;
      case 2: return _musicKey.currentState;
      case 3: return _danceKey.currentState;
      case 4: return _theatreKey.currentState;
      case 5: return _othersKey.currentState;
      default: return null;
    }
  }

  String _getCurrentCategory() {
    switch (_currentTabIndex) {
      case 1: return 'Sport';
      case 2: return 'Musique';
      case 3: return 'Danse';
      case 4: return 'Théâtre';
      case 5: return 'Autres';
      default: return 'Tous les clubs';
    }
  }

  // Obtenir les dates disponibles depuis les clubs
  List<DateTime> _getAvailableDates() {
    return allClubs
        .map((club) => DateTime(
            club.createdAt.year,
            club.createdAt.month,
            club.createdAt.day))
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));
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
                  label: 'Membres',
                  value: totalMembers,
                  icon: Iconsax.people,
                  color: Colors.blue),
              SummaryItem(
                  label: 'Coachs',
                  value: totalInstructors,
                  icon: Iconsax.user,
                  color: Colors.red),
              SummaryItem(
                  label: 'Clubs',
                  value: allClubs.length,
                  icon: Iconsax.calendar,
                  color: Colors.green),
              SummaryItem(
                  label: 'Équipements',
                  value: totalEquipment,
                  icon: Icons.sports_soccer,
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
                        "Aperçu des clubs",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: bGris10,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: widget.onAddPressed,
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text("Ajouter Club"),
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
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        tabs: const [
                          Tab(text: 'Tous les clubs'),
                          Tab(text: "Sport"),
                          Tab(text: "Musique"),
                          Tab(text: "Danse"),
                          Tab(text: "Théâtre"),
                          Tab(text: "Autres"),
                        ],
                        labelColor: bPrimaryColor,
                        unselectedLabelColor: bGris10,
                        indicatorColor: bPrimaryColor,
                        isScrollable: true,
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Onglet "Tous les clubs" avec filtres
                            Column(
                              children: [
                                // Section des dropdowns et de la barre de recherche
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      // Dropdown pour la date
                                      Container(
                                        width: 140,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.grey),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.calendar_today,
                                                size: 16, color: Colors.grey),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: DropdownButton<String>(
                                                isExpanded: true,
                                                underline: const SizedBox(),
                                                value: _selectedDate,
                                                hint: const Text('Date',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.grey,
                                                        fontFamily: 'Poppins')),
                                                items: [
                                                  const DropdownMenuItem<String>(
                                                    value: null,
                                                    child: Text('Toutes les dates'),
                                                  ),
                                                  ..._getAvailableDates().map((date) {
                                                    return DropdownMenuItem<String>(
                                                      value: '${date.day}/${date.month}/${date.year}',
                                                      child: Text('${date.day}/${date.month}/${date.year}'),
                                                    );
                                                  }),
                                                ],
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedDate = value;
                                                  });
                                                  _updateCurrentGridView();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),

                                      // Dropdown pour le club
                                      Container(
                                        width: 120,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.grey),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.sports_soccer,
                                                size: 16, color: Colors.grey),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: DropdownButton<String>(
                                                isExpanded: true,
                                                underline: const SizedBox(),
                                                value: _selectedClub,
                                                hint: const Text('Club',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.grey,
                                                        fontFamily: 'Poppins')),
                                                items: [
                                                  const DropdownMenuItem<String>(
                                                    value: null,
                                                    child: Text('Tous les clubs'),
                                                  ),
                                                  ...availableClubs.map((clubName) {
                                                    return DropdownMenuItem<String>(
                                                      value: clubName,
                                                      child: Text(clubName),
                                                    );
                                                  }),
                                                ],
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedClub = value;
                                                  });
                                                  _updateCurrentGridView();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),

                                      // Dropdown pour le prix
                                      Container(
                                        width: 120,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.grey),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.attach_money,
                                                size: 16, color: Colors.grey),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: DropdownButton<String>(
                                                isExpanded: true,
                                                underline: const SizedBox(),
                                                value: _selectedPrice,
                                                hint: const Text('Prix',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.grey,
                                                        fontFamily: 'Poppins')),
                                                items: const [
                                                  DropdownMenuItem<String>(
                                                    value: null,
                                                    child: Text('Tous les prix'),
                                                  ),
                                                  DropdownMenuItem<String>(
                                                    value: 'Gratuit',
                                                    child: Text('Gratuit'),
                                                  ),
                                                  DropdownMenuItem<String>(
                                                    value: 'Payant',
                                                    child: Text('Payant'),
                                                  ),
                                                ],
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedPrice = value;
                                                  });
                                                  _updateCurrentGridView();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),

                                      // Dropdown pour l'animateur
                                      SizedBox(
                                        width: 170,
                                        height: 32,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(24),
                                            border: Border.all(color: Colors.grey),
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.person,
                                                  size: 16, color: Colors.grey),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  underline: const SizedBox(),
                                                  value: _selectedInstructor,
                                                  hint: const Text('Animateur',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.grey,
                                                          fontFamily: 'Poppins')),
                                                  items: [
                                                    const DropdownMenuItem<String>(
                                                      value: null,
                                                      child: Text('Tous les animateurs'),
                                                    ),
                                                    ...availableInstructors.map((instructor) {
                                                      return DropdownMenuItem<String>(
                                                        value: instructor,
                                                        child: Text(instructor),
                                                      );
                                                    }),
                                                  ],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedInstructor = value;
                                                    });
                                                    _updateCurrentGridView();
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Spacer(),

                                      // Barre de recherche
                                      Expanded(
                                        child: TextField(
                                          controller: _searchController,
                                          style: const TextStyle(fontSize: 14),
                                          decoration: InputDecoration(
                                            hintText: 'Rechercher...',
                                            hintStyle: const TextStyle(
                                                color: Colors.grey, fontSize: 14),
                                            prefixIcon: const Icon(Icons.search,
                                                size: 20, color: Colors.grey),
                                            filled: true,
                                            fillColor: bGris9,
                                            contentPadding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
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
                                    ],
                                  ),
                                ),
                                // Contenu principal (Liste des clubs)
                                Expanded(
                                  child: ClubsGridView(
                                    key: _allClubsKey,
                                    category: 'Tous les clubs',
                                    dateFilter: _selectedDate,
                                    searchQuery: _searchQuery,
                                    instructor: _selectedInstructor,
                                    priceRange: _selectedPrice,
                                  ),
                                ),
                              ],
                            ),
                            // Autres onglets sans filtres
                            ClubsGridView(
                              key: _sportKey,
                              category: 'Sport',
                              searchQuery: _searchQuery,
                            ),
                            ClubsGridView(
                              key: _musicKey,
                              category: 'Musique',
                              searchQuery: _searchQuery,
                            ),
                            ClubsGridView(
                              key: _danceKey,
                              category: 'Danse',
                              searchQuery: _searchQuery,
                            ),
                            ClubsGridView(
                              key: _theatreKey,
                              category: 'Théâtre',
                              searchQuery: _searchQuery,
                            ),
                            ClubsGridView(
                              key: _othersKey,
                              category: 'Autres',
                              searchQuery: _searchQuery,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}