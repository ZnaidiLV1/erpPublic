import 'dart:convert';
import 'package:biboo_pro/presentation/club/components/ClubData.dart';
import 'package:biboo_pro/presentation/club/components/club_data_statique.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/colors.dart';

class DaySchedule {
  final String day;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  DaySchedule({
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  String getDuration(BuildContext context) {
    int startMinutes = startTime.hour * 60 + startTime.minute;
    int endMinutes = endTime.hour * 60 + endTime.minute;

    if (endMinutes < startMinutes) {
      endMinutes += 24 * 60;
    }

    int durationMinutes = endMinutes - startMinutes;
    
    if (durationMinutes <= 0) return "Invalide";

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

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'startTime': {'hour': startTime.hour, 'minute': startTime.minute},
      'endTime': {'hour': endTime.hour, 'minute': endTime.minute},
    };
  }

  factory DaySchedule.fromJson(Map<String, dynamic> json) {
    return DaySchedule(
      day: json['day'],
      startTime: TimeOfDay(
        hour: json['startTime']['hour'],
        minute: json['startTime']['minute'],
      ),
      endTime: TimeOfDay(
        hour: json['endTime']['hour'],
        minute: json['endTime']['minute'],
      ),
    );
  }
}

class AddClub extends StatefulWidget {
  final VoidCallback onCancelPressed;
  const AddClub({super.key, required this.onCancelPressed});

  @override
  State<AddClub> createState() => _AddClubState();
}

class _AddClubState extends State<AddClub> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  String? selectedOption;
  String? _selectedInstructor;
  String? _selectedClasseConcernee;
  bool _disposed = false;
  String? _selectedImagePath;
  List<ClubDataEntity> recentClubs = [];
  List<ClubDataEntity> filteredRecentClubs = [];
  bool _isPrivateShare = false;
  bool _isPublicShare = false;
  bool isTypeArabic = false;
  bool isDescriptionArabic = false;
  ClubData? selectedClubData;
  String customType = '';
  String customDescription = '';
  List<DaySchedule> daySchedules = [];
  DateTime? _startDate;
  DateTime? _endDate;
  final List<String> daysOfWeek = [
    'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'
  ];

  final List<String> classesDisponibles = [

  'B - Bébés (6 – 12 mois)',
  'TP - Tout-petits (12 – 24 mois)', 
  'PPS - Pré-Petite Section (24 – 30 mois / 2 ans – 3 ans)',
  
 
  'TPS - Toute Petite Section (2 – 3 ans)',
  'PS - Petite Section (3 – 4 ans)',
  'MS - Moyenne Section (4 – 5 ans)',
  'GS - Grande Section (5 – 6 ans)',
  

  'CP - Classe Préparatoire (6 – 7 ans)',
  'Garderie scolaire',
  '1ère année',
  '2ème année', 
  '3ème année',
  '4ème année',
  '5ème année',
  '6ème année',
  'Complexe éducatif privé',
];

 
  @override
  void initState() {
    super.initState();
    _loadStoredClubs();
  }

  @override
  void dispose() {
    _disposed = true;
    _capacityController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _adresseController.dispose();
    super.dispose();
  }
  Future<void> _loadStoredClubs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final clubsJson = prefs.getString('clubs');
      
      if (clubsJson != null && mounted) {
        final List<dynamic> decodedClubs = json.decode(clubsJson);
        setState(() {
          recentClubs = decodedClubs
              .map((clubJson) => ClubDataEntity.fromJson(clubJson))
              .toList();
          recentClubs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          filteredRecentClubs = List.from(recentClubs);
        });
      }
    } catch (e) {
      print('Erreur lors du chargement des clubs: $e');
    }
  }
  Future<void> _saveClubs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final clubsJson = json.encode(recentClubs.map((e) => e.toJson()).toList());
      await prefs.setString('clubs', clubsJson);
      print('Clubs sauvegardés: $clubsJson');
    } catch (e) {
      print('Erreur lors de la sauvegarde des clubs: $e');
    }
  }
  void _filterClubs(String query) {
    if (mounted) {
      setState(() {
        if (query.isEmpty) {
          filteredRecentClubs = List.from(recentClubs);
        } else {
          filteredRecentClubs = recentClubs
              .where((club) => 
                  club.type.toLowerCase().contains(query.toLowerCase()) ||
                  club.instructor.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      });
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) {
      return "Aujourd'hui";
    } else if (difference == 1) {
      return "Hier";
    } else if (difference < 7) {
      return "Il y a $difference jours";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }
  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      helpText: 'Sélectionnez la date de début',
      cancelText: 'Annuler',
      confirmText: 'Confirmer',
    );
    
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        if (_endDate != null && _endDate!.isBefore(_startDate!)) {
          _endDate = null;
        }
      });
    }
  }
  Future<void> _selectEndDate() async {
    if (_startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez d\'abord sélectionner une date de début'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate!.add(const Duration(days: 30)),
      firstDate: _startDate!,
      lastDate: _startDate!.add(const Duration(days: 365 * 2)),
      helpText: 'Sélectionnez la date de fin',
      cancelText: 'Annuler',
      confirmText: 'Confirmer',
    );
    
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }
  int _calculatePeriodInMonths() {
    if (_startDate == null || _endDate == null) return 0;
    
    int yearDiff = _endDate!.year - _startDate!.year;
    int monthDiff = _endDate!.month - _startDate!.month;
    int totalMonths = yearDiff * 12 + monthDiff;
    
    if (_endDate!.day < _startDate!.day) {
      totalMonths--;
    }
    
    return totalMonths > 0 ? totalMonths : 1;
  }

  void _showAddDayDialog() {
    String? selectedDay;
    TimeOfDay? startTime;
    TimeOfDay? endTime;

    final availableDays = daysOfWeek.where((day) => 
      !daySchedules.any((schedule) => schedule.day == day)
    ).toList();

    if (availableDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tous les jours de la semaine ont déjà été ajoutés'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Ajouter un jour'),
              content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jour de la semaine',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedDay,
                      decoration: InputDecoration(
                        hintText: 'Sélectionnez un jour',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: availableDays.map((day) {
                        return DropdownMenuItem<String>(
                          value: day,
                          child: Text(day),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          selectedDay = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Heure début',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () async {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (time != null) {
                                    setDialogState(() {
                                      startTime = time;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    startTime?.format(context) ?? 'Sélectionner',
                                    style: TextStyle(
                                      color: startTime == null ? Colors.grey : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Heure fin',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () async {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (time != null) {
                                    setDialogState(() {
                                      endTime = time;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    endTime?.format(context) ?? 'Sélectionner',
                                    style: TextStyle(
                                      color: endTime == null ? Colors.grey : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    if (selectedDay != null && startTime != null && endTime != null) {
                      if (mounted) {
                        setState(() {
                          daySchedules.add(DaySchedule(
                            day: selectedDay!,
                            startTime: startTime!,
                            endTime: endTime!,
                          ));
                        });
                      }
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Ajouter'),
                ),
              ],
            );
          },
        );
      },
    );
  }
  void _removeDaySchedule(int index) {
    if (mounted) {
      setState(() {
        daySchedules.removeAt(index);
      });
    }
  }

  String _getTotalPeriodDuration() {
    if (daySchedules.isEmpty) return "0h";
    
    int totalMinutes = 0;
    for (var schedule in daySchedules) {
      int startMinutes = schedule.startTime.hour * 60 + schedule.startTime.minute;
      int endMinutes = schedule.endTime.hour * 60 + schedule.endTime.minute;
      
      if (endMinutes < startMinutes) {
        endMinutes += 24 * 60;
      }
      
      totalMinutes += (endMinutes - startMinutes);
    }
    
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;
    
    if (hours == 0) {
      return "${minutes}min";
    } else if (minutes == 0) {
      return "${hours}h";
    } else {
      return "${hours}h ${minutes}min";
    }
  }

  // Ajout d'un nouveau club
  Future<void> _addToRecentClubs() async {
    String clubType = '';
    String clubDescription = '';
    
    if (selectedClubData != null) {
      clubType = isTypeArabic ? selectedClubData!.nomAr : selectedClubData!.nomFr;
      clubDescription = isDescriptionArabic ? selectedClubData!.descriptionAr : selectedClubData!.descriptionFr;
    } else {
      clubType = customType;
      clubDescription = customDescription.isNotEmpty ? customDescription : _descriptionController.text.trim();
    }
    
    if (clubType.isNotEmpty && _selectedInstructor != null && daySchedules.isNotEmpty) {
      final String clubId = DateTime.now().millisecondsSinceEpoch.toString();
      
      List<String> schedule = daySchedules.map((ds) => 
        '${ds.day}: ${ds.startTime.format(context)} - ${ds.endTime.format(context)} (${ds.getDuration(context)})'
      ).toList();

      final newClub = ClubDataEntity(
        id: clubId,
        type: clubType,
        description: clubDescription,
        category: null,
        instructor: _selectedInstructor!,
        capacity: int.tryParse(_capacityController.text) ?? 0,
        imagePath: _selectedImagePath,
        price: (selectedOption == 'Payant') ? _priceController.text.trim() : '0',
        isPaid: selectedOption == 'Payant',
        startTime: daySchedules.isNotEmpty ? daySchedules.first.startTime : null,
        endTime: daySchedules.isNotEmpty ? daySchedules.first.endTime : null,
        selectedDay: daySchedules.isNotEmpty ? daySchedules.first.day : null,
        isPrivateShare: _isPrivateShare,
        isPublicShare: _isPublicShare,
        createdAt: DateTime.now(),
        schedule: schedule,
        periodInMonths: _calculatePeriodInMonths(),
        daySchedules: daySchedules.map((ds) => ds.toJson()).toList(),
        classeConcernee: _selectedClasseConcernee,
        adresse: _adresseController.text.trim().isNotEmpty ? _adresseController.text.trim() : null,
      );
      
      if (mounted) {
        setState(() {
          recentClubs.insert(0, newClub);
          if (recentClubs.length > 50) {
            recentClubs = recentClubs.take(50).toList();
          }
          filteredRecentClubs = List.from(recentClubs);
        });
        
        await _saveClubs();
      }
    }
  }
  Future<void> _deleteClub(int index) async {
    if (mounted) {
      setState(() {
        final clubToDelete = filteredRecentClubs[index];
        recentClubs.removeWhere((club) => club.id == clubToDelete.id);
        filteredRecentClubs.removeAt(index);
      });
      await _saveClubs();
    }
  }

  void _loadClubToForm(ClubDataEntity club) {
    if (mounted) {
      ClubData? matchingClubData;
      for (var clubData in clubDataList) {
        if (clubData.nomAr == club.type || clubData.nomFr == club.type) {
          matchingClubData = clubData;
          break;
        }
      }

      setState(() {
        if (matchingClubData != null) {
          selectedClubData = matchingClubData;
          customType = '';
          customDescription = '';
          isTypeArabic = matchingClubData.nomAr == club.type;
          isDescriptionArabic = matchingClubData.descriptionAr == club.description;
        } else {
          selectedClubData = null;
          customType = club.type;
          customDescription = club.description;
          _descriptionController.text = customDescription;
        }

        _selectedInstructor = club.instructor;
        _selectedClasseConcernee = club.classeConcernee;
        _adresseController.text = club.adresse ?? '';
        _capacityController.text = club.capacity.toString();
        _selectedImagePath = club.imagePath;
        selectedOption = club.isPaid ? 'Payant' : 'Gratuit';
        if (club.isPaid) {
          _priceController.text = club.price;
        }
        _isPrivateShare = club.isPrivateShare;
        _isPublicShare = club.isPublicShare;
        if (club.periodInMonths != null) {
          _startDate = DateTime.now();
          _endDate = DateTime.now().add(Duration(days: club.periodInMonths! * 30));
        }
        
        if (club.daySchedules != null && club.daySchedules!.isNotEmpty) {
          daySchedules = club.daySchedules!.map((ds) => DaySchedule.fromJson(ds)).toList();
        } else {
          daySchedules.clear();
          if (club.selectedDay != null && club.startTime != null && club.endTime != null) {
            daySchedules.add(DaySchedule(
              day: club.selectedDay!,
              startTime: club.startTime!,
              endTime: club.endTime!,
            ));
          }
        }
      });
    }
  }

List<String> _getAvailableImagesForEventType() {
  String currentEventType = '';
  
  if (selectedClubData != null) {
    currentEventType = isTypeArabic ? selectedClubData!.nomAr : selectedClubData!.nomFr;
  } else if (customType.isNotEmpty) {
    currentEventType = customType;
  }
  
  if (currentEventType.isEmpty) {
    return availableClubImages;
  }
  
  return imagesByClubType[currentEventType] ?? availableClubImages;
}

void _showImagePicker() {
  final availableImages = _getAvailableImagesForEventType();
  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          selectedClubData != null || customType.isNotEmpty 
            ? 'Images pour ${selectedClubData != null ? (isTypeArabic ? selectedClubData!.nomAr : selectedClubData!.nomFr) : customType}'
            : 'Sélectionner une image'
        ),
        content: SizedBox(
          width: 900,
          height: 400,
          child: availableImages.isEmpty 
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('Aucune image disponible pour ce type d\'événement'),
                    SizedBox(height: 8),
                    Text('Sélectionnez d\'abord un type d\'événement', 
                         style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (selectedClubData != null || customType.isNotEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.info, color: Colors.blue, size: 16),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Images spécifiques pour ce type d\'événement (${availableImages.length} disponibles)',
                                style: const TextStyle(fontSize: 12, color: Colors.blue),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                _showAllImagesDialog();
                              },
                              child: const Text('Voir toutes', style: TextStyle(fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: availableImages.map((imagePath) {
                        final isSelected = _selectedImagePath == imagePath;
                        return GestureDetector(
                          onTap: () {
                            if (!_disposed && mounted) {
                              setState(() {
                                _selectedImagePath = imagePath;
                              });
                            }
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected ? Colors.blue : Colors.grey,
                                width: isSelected ? 3 : 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                imagePath,
                               fit: BoxFit.fill, 
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 120,
                                    height: 120,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.error),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
        ),
        actions: [
          if (selectedClubData != null || customType.isNotEmpty)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showAllImagesDialog();
              },
              child: const Text('Toutes les images'),
            ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
        ],
      );
    },
  );
}

void _showAllImagesDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Toutes les images disponibles'),
        content: SizedBox(
          width: 900,
          height: 400,
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: availableClubImages.map((imagePath) {
                final isSelected = _selectedImagePath == imagePath;
                return GestureDetector(
                  onTap: () {
                    if (!_disposed && mounted) {
                      setState(() {
                        _selectedImagePath = imagePath;
                      });
                    }
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey,
                        width: isSelected ? 3 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.fill, 
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 120,
                            height: 120,
                            color: Colors.grey[300],
                            child: const Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
        ],
      );
    },
  );
}
  void _deleteImage() {
    if (!_disposed && mounted) {
      setState(() {
        _selectedImagePath = null;
      });
    }
  }

  void _updateImage() {
    _showImagePicker();
  }

  void _showShareDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Partager le club'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choisissez les options de partage :',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  CheckboxListTile(
                    title: const Text('Partage privé'),
                    subtitle: const Text('Visible uniquement par les membres autorisés'),
                    value: _isPrivateShare,
                    onChanged: (bool? value) {
                      setDialogState(() {
                        _isPrivateShare = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    title: const Text('Partage public'),
                    subtitle: const Text('Visible par tous les utilisateurs'),
                    value: _isPublicShare,
                    onChanged: (bool? value) {
                      setDialogState(() {
                        _isPublicShare = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Annuler'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _handleShare();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Partager'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _handleShare() {
    if (!_isPrivateShare && !_isPublicShare) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner au moins une option de partage'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    String shareMessage = 'Club partagé avec succès :\n';
    if (_isPrivateShare) {
      shareMessage += '• Partage privé activé\n';
    }
    if (_isPublicShare) {
      shareMessage += '• Partage public activé\n';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(shareMessage),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );

    setState(() {
      _isPrivateShare = false;
      _isPublicShare = false;
    });
  }

  void _showCustomTypeDialog() {
    String tempType = customType;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Type de club personnalisé'),
          content: TextField(
            controller: TextEditingController(text: tempType),
            onChanged: (value) => tempType = value,
            decoration: const InputDecoration(
              hintText: 'Entrez le type de club',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                if (mounted) {
                  setState(() {
                    customType = tempType.trim();
                    selectedClubData = null;
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionCard(String title, List<Widget> children, {IconData? icon}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20, color: Colors.blue),
                  const SizedBox(width: 8),
                ],
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          children: [
            if (isRequired)
              const TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }

  InputDecoration _roundedInputDecoration(String label, String helper, {IconData? prefixIcon}) {
    return InputDecoration(
      labelText: label,
      hintText: helper,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.grey[600]) : null,
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _buildClubTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _buildLabel("Type de club", isRequired: true)),
            IconButton(
              onPressed: () {
                if (mounted) {
                  setState(() {
                    isTypeArabic = !isTypeArabic;
                  });
                }
              },
              icon: Icon(
                isTypeArabic ? Icons.translate : Icons.language,
                color: isTypeArabic ? Colors.green : Colors.blue,
              ),
              tooltip: isTypeArabic ? 'Basculer vers Français' : 'Basculer vers Arabe',
            ),
          ],
        ),
        DropdownButtonFormField<String>(
          decoration: _roundedInputDecoration(
            "Type de club",
            "Sélectionnez le type de club",
          ),
          value: _getSelectedTypeValue(),
          validator: (value) {
            if ((selectedClubData == null && customType.isEmpty)) {
              return 'Veuillez sélectionner un type de club';
            }
            return null;
          },
          items: [
            ...clubDataList.map((clubData) {
              String displayText = isTypeArabic ? clubData.nomAr : clubData.nomFr;
              return DropdownMenuItem<String>(
                value: displayText,
                child: Directionality(
                  textDirection: isTypeArabic ? TextDirection.rtl : TextDirection.ltr,
                  child: Text(
                    displayText,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: isTypeArabic ? 'Arabic' : null,
                    ),
                  ),
                ),
              );
            }),
            const DropdownMenuItem<String>(
              value: 'custom_type',
              child: Row(
                children: [
                  Icon(Icons.add, size: 16, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('Autres...', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
          ],
          onChanged: (value) {
            if (value == 'custom_type') {
              if (mounted) {
                setState(() {
                  selectedClubData = null;
                });
              }
              _showCustomTypeDialog();
            } else if (value != null) {
              if (mounted) {
                setState(() {
                  selectedClubData = clubDataList.firstWhere(
                    (data) => (isTypeArabic ? data.nomAr : data.nomFr) == value,
                  );
                  customType = '';
                });
              }
            }
          },
        ),
        if (selectedClubData == null && customType.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info, color: Colors.blue, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Type personnalisé: $customType',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  TextButton(
                    onPressed: _showCustomTypeDialog,
                    child: const Text('Modifier', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  String? _getSelectedTypeValue() {
    if (selectedClubData != null) {
      return isTypeArabic ? selectedClubData!.nomAr : selectedClubData!.nomFr;
    } else if (customType.isNotEmpty) {
      return null;
    }
    return null;
  }
String _selectedFont = 'Default';
final List<String> _availableFonts = [
  'Default',
  'Roboto',
  'Arial',
  'Times New Roman',
  'Georgia',
  'Verdana',
  'Comic Sans MS',
  'Impact',
  'Trebuchet MS',
  'Courier New',
];

Widget _buildDescriptionField() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(child: _buildLabel("Description", isRequired: true)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: _selectedFont,
              underline: const SizedBox(),
              icon: const Icon(Icons.font_download, size: 16),
              hint: const Text('Police', style: TextStyle(fontSize: 12)),
              items: _availableFonts.map((font) {
                return DropdownMenuItem<String>(
                  value: font,
                  child: Text(
                    font,
                    style: TextStyle(
                      fontFamily: font == 'Default' ? null : font,
                      fontSize: 12,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (mounted && value != null) {
                  setState(() {
                    _selectedFont = value;
                  });
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              if (mounted) {
                setState(() {
                  isDescriptionArabic = !isDescriptionArabic;
                });
              }
            },
            icon: Icon(
              isDescriptionArabic ? Icons.translate : Icons.language,
              color: isDescriptionArabic ? Colors.green : Colors.blue,
            ),
            tooltip: isDescriptionArabic ? 'Basculer vers Français' : 'Basculer vers Arabe',
          ),
        ],
      ),
      if (selectedClubData != null)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.description, color: Colors.grey[600], size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'Description prédéfinie:',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _selectedFont,
                      style: const TextStyle(fontSize: 10, color: Colors.blue),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => _showCustomDescriptionDialog(),
                    child: const Text('Personnaliser', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Directionality(
                textDirection: isDescriptionArabic ? TextDirection.rtl : TextDirection.ltr,
                child: Text(
                  isDescriptionArabic 
                      ? selectedClubData!.descriptionAr 
                      : selectedClubData!.descriptionFr,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    fontFamily: _selectedFont == 'Default' 
                        ? (isDescriptionArabic ? 'Arabic' : null)
                        : _selectedFont,
                  ),
                ),
              ),
            ],
          ),
        )
      else
        Column(
          children: [
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              style: TextStyle(
                fontFamily: _selectedFont == 'Default' ? null : _selectedFont,
                fontSize: 14,
              ),
              decoration: _roundedInputDecoration(
                "Description",
                customDescription.isEmpty 
                    ? "Décrivez votre événement en détail..."
                    : customDescription,
                prefixIcon: Icons.description,
              ),
              validator: (value) {
                if (selectedClubData == null && 
                    (value == null || value.trim().isEmpty) && 
                    customDescription.isEmpty) {
                  return 'Veuillez ajouter une description';
                }
                return null;
              },
              onChanged: (value) {
                if (mounted) {
                  setState(() {
                    customDescription = value;
                  });
                }
              },
            ),
            if (customDescription.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Description personnalisée avec police: $_selectedFont',
                          style: const TextStyle(fontSize: 12)
                        )
                      ),
                      TextButton(
                        onPressed: _showCustomDescriptionDialog,
                        child: const Text('Modifier', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
    ],
  );
}

void _showCustomDescriptionDialog() {
  String tempDescription = '';
  String tempSelectedFont = _selectedFont;
  
  if (selectedClubData != null) {
    tempDescription = isDescriptionArabic 
        ? selectedClubData!.descriptionAr 
        : selectedClubData!.descriptionFr;
  } else if (customDescription.isNotEmpty) {
    tempDescription = customDescription;
  } else {
    tempDescription = _descriptionController.text;
  }
  
  final TextEditingController tempController = TextEditingController(text: tempDescription);
  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Description personnalisée'),
            content: SizedBox(
              width: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Police d\'écriture: ', style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DropdownButton<String>(
                          value: tempSelectedFont,
                          isExpanded: true,
                          items: _availableFonts.map((font) {
                            return DropdownMenuItem<String>(
                              value: font,
                              child: Text(
                                font,
                                style: TextStyle(
                                  fontFamily: font == 'Default' ? null : font,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(() {
                                tempSelectedFont = value;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: tempController,
                    onChanged: (value) => tempDescription = value,
                    maxLines: 6,
                    style: TextStyle(
                      fontFamily: tempSelectedFont == 'Default' ? null : tempSelectedFont,
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Modifiez la description selon vos besoins...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Aperçu avec la police: $tempSelectedFont',
                      style: TextStyle(
                        fontFamily: tempSelectedFont == 'Default' ? null : tempSelectedFont,
                        fontSize: 12,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  tempController.dispose();
                  Navigator.of(context).pop();
                },
                child: const Text('Annuler'),
              ),
              TextButton(
                onPressed: () {
                  if (mounted) {
                    setState(() {
                      customDescription = tempController.text.trim();
                      selectedClubData = null;
                      _selectedFont = tempSelectedFont;
                      _descriptionController.text = customDescription;
                    });
                  }
                  tempController.dispose();
                  Navigator.of(context).pop();
                },
                child: const Text('Confirmer'),
              ),
            ],
          );
        },
      );
    },
  );
}

  Widget _buildScheduleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _buildLabel("Horaires", isRequired: true)),
            ElevatedButton.icon(
              onPressed: _showAddDayDialog,
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Ajouter un jour', style: TextStyle(fontSize: 12)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                minimumSize: Size.zero,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (daySchedules.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              children: [
                Icon(Icons.schedule, size: 48, color: Colors.grey[400]),
                const SizedBox(height: 8),
                Text(
                  'Aucun horaire ajouté',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Cliquez sur "Ajouter un jour" pour définir les horaires',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
        else
          Column(
            children: [
              ...daySchedules.asMap().entries.map((entry) {
                int index = entry.key;
                DaySchedule schedule = entry.value;
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: Text(
                            schedule.day,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '${schedule.startTime.format(context)} - ${schedule.endTime.format(context)}',
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            schedule.getDuration(context),
                            style: TextStyle(
                              color: Colors.green[700],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () => _removeDaySchedule(index),
                          icon: const Icon(Icons.delete, size: 18),
                          color: Colors.red,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.timer, color: Colors.blue, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Durée totale de la période: ',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _getTotalPeriodDuration(),
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Créer un Club",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onCancelPressed,
        ),
        actions: [
          if (recentClubs.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Effacer tous les clubs'),
                      content: const Text('Êtes-vous sûr de vouloir supprimer tous les clubs récents ?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Annuler'),
                        ),
                        TextButton(
                          onPressed: () async {
                            if (mounted) {
                              setState(() {
                                recentClubs.clear();
                                filteredRecentClubs.clear();
                              });
                            }
                            await _saveClubs();
                            Navigator.of(context).pop();
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Tous les clubs ont été supprimés'),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                            }
                          },
                          child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          // Panneau latéral des clubs récents
          Container(
            width: 280,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Clubs récents',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${recentClubs.length}',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        onChanged: _filterClubs,
                        decoration: _roundedInputDecoration(
                          "",
                          "Rechercher des clubs...",
                          prefixIcon: Icons.search,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: filteredRecentClubs.isEmpty 
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.groups, size: 48, color: Colors.grey[400]),
                            const SizedBox(height: 8),
                            Text(
                              recentClubs.isEmpty 
                                ? 'Aucun club créé'
                                : 'Aucun club trouvé',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            if (recentClubs.isEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'Créez votre premier club !',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredRecentClubs.length,
                        itemBuilder: (context, index) {
                          final club = filteredRecentClubs[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _formatDate(club.createdAt),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    club.type,
                                    style: TextStyle(
                                      color: Colors.blue[700],
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    club.instructor,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              leading: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: index == 0 && recentClubs.indexOf(club) == 0 
                                    ? Colors.green 
                                    : Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              trailing: PopupMenuButton<String>(
                                iconSize: 16,
                                onSelected: (value) async {
                                  if (value == 'load') {
                                    _loadClubToForm(club);
                                  } else if (value == 'delete') {
                                    await _deleteClub(index);
                                  }
                                },
                                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'load',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit, size: 16, color: Colors.blue),
                                        SizedBox(width: 8),
                                        Text('Charger'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, size: 16, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text('Supprimer'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => _loadClubToForm(club),
                            ),
                          );
                        },
                      ),
                ),
              ],
            ),
          ),
            const VerticalDivider(width: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionCard(
                        "Image de l'événement",
                        [
                          Container(
                            width: double.infinity,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _selectedImagePath != null ? Colors.blue : Colors.grey[300]!,
                                width: _selectedImagePath != null ? 2 : 1,
                              ),
                            ),
                            child: Stack(
                              children: [
                                if (_selectedImagePath != null)
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        _selectedImagePath!,
                                         fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                else
                                  const Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_photo_alternate_outlined,
                                          size: 48,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Cliquez pour ajouter une image',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: _showImagePicker,
                                          icon: const Icon(Icons.add_photo_alternate, size: 20),
                                          color: Colors.blue,
                                        ),
                                        if (_selectedImagePath != null) ...[
                                          IconButton(
                                            onPressed: _updateImage,
                                            icon: const Icon(Icons.edit, size: 20),
                                            color: Colors.orange,
                                          ),
                                          IconButton(
                                            onPressed: _deleteImage,
                                            icon: const Icon(Icons.delete, size: 20),
                                            color: Colors.red,
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        icon: Icons.image,
                      ),

_buildSectionCard(
  "Informations générales",
  [
    _buildClubTypeSelector(),
    const SizedBox(height: 16),
    _buildDescriptionField(),
    const SizedBox(height: 16),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Instructeur", isRequired: true),
        DropdownButtonFormField<String>(
          value: _selectedInstructor,
          decoration: _roundedInputDecoration(
            "Instructeur",
            "Sélectionnez un instructeur",
            prefixIcon: Icons.person,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez sélectionner un instructeur';
            }
            return null;
          },
          items: instructorsList.map((instructor) {
            return DropdownMenuItem<String>(
              value: instructor,
              child: Text(instructor),
            );
          }).toList(),
          onChanged: (value) {
            if (mounted) {
              setState(() => _selectedInstructor = value);
            }
          },
        ),
      ],
    ),
    const SizedBox(height: 16),
    // New Address Field
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Adresse du club"),
        TextFormField(
          controller: _adresseController,
          decoration: _roundedInputDecoration(
            "Adresse",
            "Entrez l'adresse complète du club",
            prefixIcon: Icons.location_on,
          ),
          validator: (value) {
            // Address is optional, so no validation required
            return null;
          },
          maxLines: 2,
        ),
      ],
    ),
    const SizedBox(height: 16),
    // New Class Selection Field
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Classes concernées", isRequired: true),
        DropdownButtonFormField<String>(
          value: _selectedClasseConcernee,
          decoration: _roundedInputDecoration(
            "Classes concernées",
            "Sélectionnez les classes ciblées",
            prefixIcon: Icons.school,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez sélectionner les classes concernées';
            }
            return null;
          },
          items: classesDisponibles.map((classe) {
            return DropdownMenuItem<String>(
              value: classe,
              child: Text(classe),
            );
          }).toList(),
          onChanged: (value) {
            if (mounted) {
              setState(() => _selectedClasseConcernee = value);
            }
          },
        ),
      ],
    ),
  ],
  icon: Icons.info_outline,
),

                      // Section Capacité et période
                      _buildSectionCard(
                        "Capacité et période",
                        [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel("Capacité maximale", isRequired: true),
                                    TextFormField(
                                      controller: _capacityController,
                                      keyboardType: TextInputType.number,
                                      decoration: _roundedInputDecoration(
                                        "Capacité",
                                        "Nombre maximum d'enfants",
                                        prefixIcon: Icons.groups,
                                      ),
                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return 'Veuillez entrer une capacité';
                                        }
                                        final capacity = int.tryParse(value);
                                        if (capacity == null || capacity <= 0) {
                                          return 'Veuillez entrer un nombre valide';
                                        }
                                        return null;
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel("Période du club", isRequired: true),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () => _selectStartDate(),
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[50],
                                                border: Border.all(
                                                  color: _startDate == null ? Colors.grey[300]! : Colors.blue,
                                                ),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_today,
                                                    size: 16,
                                                    color: _startDate == null ? Colors.grey[600] : Colors.blue,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      _startDate == null 
                                                        ? 'Date début'
                                                        : '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}',
                                                      style: TextStyle(
                                                        color: _startDate == null ? Colors.grey[600] : Colors.black87,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () => _selectEndDate(),
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[50],
                                                border: Border.all(
                                                  color: _endDate == null ? Colors.grey[300]! : Colors.blue,
                                                ),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_today,
                                                    size: 16,
                                                    color: _endDate == null ? Colors.grey[600] : Colors.blue,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      _endDate == null 
                                                        ? 'Date fin'
                                                        : '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}',
                                                      style: TextStyle(
                                                        color: _endDate == null ? Colors.grey[600] : Colors.black87,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (_startDate != null && _endDate != null)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.info, color: Colors.blue, size: 16),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Durée: ${_calculatePeriodInMonths()} mois',
                                                style: const TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
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
                        ],
                        icon: Icons.schedule,
                      ),

                      // Section Horaires
                      _buildSectionCard(
                        "Planning hebdomadaire",
                        [
                          _buildScheduleSection(),
                        ],
                        icon: Icons.access_time,
                      ),

                      // Section Tarification
                      _buildSectionCard(
                        "Tarification",
                        [
                          _buildLabel("Mode de paiement", isRequired: true),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    if (mounted) {
                                      setState(() => selectedOption = 'Gratuit');
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: selectedOption == 'Gratuit' ? Colors.green.withOpacity(0.1) : Colors.grey[50],
                                      border: Border.all(
                                        color: selectedOption == 'Gratuit' ? Colors.green : Colors.grey[300]!,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          selectedOption == 'Gratuit' ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                          color: selectedOption == 'Gratuit' ? Colors.green : Colors.grey,
                                        ),
                                        const SizedBox(width: 12),
                                        const Text("Gratuit"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    if (mounted) {
                                      setState(() => selectedOption = 'Payant');
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: selectedOption == 'Payant' ? Colors.orange.withOpacity(0.1) : Colors.grey[50],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          selectedOption == 'Payant' ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                          color: selectedOption == 'Payant' ? Colors.orange : Colors.grey,
                                        ),
                                        const SizedBox(width: 12),
                                        const Text("Payant"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (selectedOption == 'Payant') ...[
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildLabel("Prix (TND)", isRequired: true),
                                      TextFormField(
                                        controller: _priceController,
                                        keyboardType: TextInputType.number,
                                       decoration: InputDecoration(
  labelText: "Prix",
  hintText: "Entrez le prix en dinars tunisiens",
  prefixText: "DT ",
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
  ),
),

                                        validator: (value) {
                                          if (selectedOption == 'Payant' && (value == null || value.trim().isEmpty)) {
                                            return 'Le prix est requis pour un club payant';
                                          }
                                          return null;
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.orange.withOpacity(0.3)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.info, color: Colors.orange, size: 16),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Prix requis',
                                          style: TextStyle(
                                            color: Colors.orange[700],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                        icon: Icons.payments,
                      ),

                      const SizedBox(height: 32),

                      // Boutons d'action
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              backgroundColor: Colors.green,
                            ),
                            onPressed: _showShareDialog,
                            icon: const Icon(Icons.share, size: 18, color: Colors.white),
                            label: const Text("Partager",
                                style: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(width: 16),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: BorderSide(color: Colors.grey[400]!),
                            ),
                            onPressed: widget.onCancelPressed,
                            child: const Text(
                              "Annuler",
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: bSecondaryColor,
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (daySchedules.isEmpty) {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Veuillez ajouter au moins un horaire'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                  return;
                                }
                                
                                if (_startDate == null || _endDate == null) {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Veuillez sélectionner les dates de début et de fin'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                  return;
                                }
                                
                                await _addToRecentClubs();
                                
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          const Icon(Icons.check_circle, color: Colors.white),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text('Club "${selectedClubData?.nomFr ?? customType}" créé et sauvegardé !'),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  );
                                  
                                  // Réinitialisation du formulaire
                                  _formKey.currentState!.reset();
                                  setState(() {
                                    selectedClubData = null;
                                    customType = '';
                                    customDescription = '';
                                    selectedOption = null;
                                    _selectedInstructor = null;
                                    _selectedImagePath = null;
                                    _isPrivateShare = false;
                                    _isPublicShare = false;
                                    isTypeArabic = false;
                                    isDescriptionArabic = false;
                                    daySchedules.clear();
                                    _startDate = null;
                                    _endDate = null;
                                  });
                                  _capacityController.clear();
                                  _descriptionController.clear();
                                  _priceController.clear();
                                }
                              }
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.save, color: Colors.white, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  "Créer le club",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }}