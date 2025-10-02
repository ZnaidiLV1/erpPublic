import '../../domain/models/club/club_model.dart';

class ClubService {
  static final ClubService _instance = ClubService._internal();
  factory ClubService() => _instance;
  ClubService._internal();

  // Sample data - in a real app, this would come from an API or database
  final List<ClubModel> _clubs = [
    ClubModel(
      id: 1,
      title: 'Club de football',
      imageUrl: 'assets/images/football.png',
      instructor: 'Mohamed Hamdi',
      price: '80 DT',
      capacity: '15 enfants',
      category: 'Sport',
      description: 'Un club sportif pour apprendre le football.',
      schedule: ['Samedi, 13:00 - 17:00', 'Dimanche, 10:00 - 16:00'],
      startDate: DateTime(2024, 1, 15),
      endDate: DateTime(2024, 6, 15),
    ),
    ClubModel(
      id: 2,
      title: 'Club de tennis',
      imageUrl: 'assets/images/football.png',
      instructor: 'Ali Ben Salah',
      price: '100 DT',
      capacity: '12 enfants',
      category: 'Sport',
      description: 'Un club pour les amateurs de tennis.',
      schedule: ['Lundi, 14:00 - 18:00', 'Mercredi, 14:00 - 18:00'],
      startDate: DateTime(2024, 2, 1),
      endDate: DateTime(2024, 7, 1),
    ),
    ClubModel(
      id: 3,
      title: 'Club de danse moderne',
      imageUrl: 'assets/images/football.png',
      instructor: 'Sara Toumi',
      price: '90 DT',
      capacity: '20 enfants',
      category: 'Danse',
      description: 'Un club pour apprendre à danser différents styles.',
      schedule: ['Mardi, 15:00 - 17:00', 'Jeudi, 15:00 - 17:00'],
      startDate: DateTime(2024, 1, 20),
      endDate: DateTime(2024, 5, 20),
    ),
    ClubModel(
      id: 4,
      title: 'Club de musique',
      imageUrl: 'assets/images/football.png',
      instructor: 'Ahmed Khelil',
      price: '120 DT',
      capacity: '10 enfants',
      category: 'Musique',
      description: 'Apprentissage de la musique et des instruments.',
      schedule: ['Vendredi, 16:00 - 18:00', 'Dimanche, 14:00 - 16:00'],
      startDate: DateTime(2024, 2, 10),
      endDate: DateTime(2024, 8, 10),
    ),
    ClubModel(
      id: 5,
      title: 'Club de théâtre',
      imageUrl: 'assets/images/football.png',
      instructor: 'Fatma Ben Ali',
      price: '70 DT',
      capacity: '18 enfants',
      category: 'Théâtre',
      description: 'Développement des compétences théâtrales.',
      schedule: ['Samedi, 10:00 - 12:00', 'Dimanche, 10:00 - 12:00'],
      startDate: DateTime(2024, 1, 25),
      endDate: DateTime(2024, 6, 25),
    ),
    ClubModel(
      id: 6,
      title: 'Club de natation',
      imageUrl: 'assets/images/football.png',
      instructor: 'Omar Trabelsi',
      price: '110 DT',
      capacity: '8 enfants',
      category: 'Sport',
      description: 'Apprentissage de la natation et sécurité aquatique.',
      schedule: ['Lundi, 17:00 - 19:00', 'Mercredi, 17:00 - 19:00'],
      startDate: DateTime(2024, 3, 1),
      endDate: DateTime(2024, 9, 1),
    ),
    ClubModel(
      id: 7,
      title: 'Club de dessin',
      imageUrl: 'assets/images/football.png',
      instructor: 'Nour Ben Youssef',
      price: '60 DT',
      capacity: '25 enfants',
      category: 'Autres',
      description: 'Développement des compétences artistiques.',
      schedule: ['Mardi, 10:00 - 12:00', 'Jeudi, 10:00 - 12:00'],
      startDate: DateTime(2024, 2, 15),
      endDate: DateTime(2024, 7, 15),
    ),
  ];

  // Get all clubs
  List<ClubModel> getAllClubs() {
    return List.from(_clubs);
  }

  // Get clubs by category
  List<ClubModel> getClubsByCategory(String category) {
    if (category == 'Tous les clubs') {
      return getAllClubs();
    }
    return _clubs.where((club) => club.category == category).toList();
  }

  // Search clubs by title or instructor
  List<ClubModel> searchClubs(String query) {
    if (query.isEmpty) return getAllClubs();
    
    return _clubs.where((club) {
      return club.title.toLowerCase().contains(query.toLowerCase()) ||
             club.instructor.toLowerCase().contains(query.toLowerCase()) ||
             club.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Filter clubs by multiple criteria
  List<ClubModel> filterClubs({
    String? category,
    String? instructor,
    String? priceRange,
    DateTime? startDate,
    DateTime? endDate,
    String? searchQuery,
  }) {
    List<ClubModel> filtered = getAllClubs();

    // Filter by category
    if (category != null && category != 'Tous les clubs') {
      filtered = filtered.where((club) => club.category == category).toList();
    }

    // Filter by instructor
    if (instructor != null && instructor.isNotEmpty) {
      filtered = filtered.where((club) => club.instructor == instructor).toList();
    }

    // Filter by price range
    if (priceRange != null && priceRange.isNotEmpty) {
      switch (priceRange) {
        case 'Moins de 70 DT':
          filtered = filtered.where((club) => club.priceAsDouble < 70).toList();
          break;
        case '70-100 DT':
          filtered = filtered.where((club) => 
            club.priceAsDouble >= 70 && club.priceAsDouble <= 100).toList();
          break;
        case 'Plus de 100 DT':
          filtered = filtered.where((club) => club.priceAsDouble > 100).toList();
          break;
      }
    }

    // Filter by date range
    if (startDate != null) {
      filtered = filtered.where((club) => 
        club.startDate != null && club.startDate!.isAfter(startDate.subtract(const Duration(days: 1)))).toList();
    }
    if (endDate != null) {
      filtered = filtered.where((club) => 
        club.endDate != null && club.endDate!.isBefore(endDate.add(const Duration(days: 1)))).toList();
    }

    // Search by query
    if (searchQuery != null && searchQuery.isNotEmpty) {
      filtered = filtered.where((club) {
        return club.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
               club.instructor.toLowerCase().contains(searchQuery.toLowerCase()) ||
               club.description.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  // Get unique instructors
  List<String> getInstructors() {
    return _clubs.map((club) => club.instructor).toSet().toList();
  }

  // Get unique categories
  List<String> getCategories() {
    return _clubs.map((club) => club.category).toSet().toList();
  }

  // Get price ranges
  List<String> getPriceRanges() {
    return ['Moins de 70 DT', '70-100 DT', 'Plus de 100 DT'];
  }

  // Get available dates (start dates of clubs)
  List<DateTime> getAvailableDates() {
    return _clubs
        .where((club) => club.startDate != null)
        .map((club) => club.startDate!)
        .toSet()
        .toList()
      ..sort();
  }
}

