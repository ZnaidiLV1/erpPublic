import 'dart:convert';

import 'package:biboo_pro/presentation/driver/driver_screen.dart';
import 'package:biboo_pro/presentation/events/components/EventData.dart';
import 'package:biboo_pro/presentation/events/components/EventDataStatique.dart';
import 'package:biboo_pro/presentation/events/components/events_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/components/app_bar.dart';
import '../../../core/constants/colors.dart';


class EventData {
  final String nomAr;
  final String nomFr;
  final String descriptionAr;
  final String descriptionFr;

  EventData({
    required this.nomAr,
    required this.nomFr,
    required this.descriptionAr,
    required this.descriptionFr,
  });
}

class EventFormScreen extends StatefulWidget {
  final VoidCallback? onCancelPressed;

  const EventFormScreen({super.key, this.onCancelPressed});

  @override
  _EventFormScreenState createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  final _formKey = GlobalKey<FormState>();

bool isEventPaid = false;
  String? selectedEvent;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  DateTime? eventDate;
  bool participationType = true;
  String? option1;
  String? option2;
String? classeConcernee; 
String? selectedClasse;
  bool hasParent = true;
  String? selectedOption1;
  String? selectedOption2;
  String? selectedDay;
  
  // État pour les langues
  bool isTypeArabic = false;
  bool isDescriptionArabic = false;
  
List<EventDataEntity> recentEvents = [];
 List<EventDataEntity> filteredRecentEvents = [];
  final TextEditingController _priceController = TextEditingController();
   final TextEditingController _AddresseController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  EventData? selectedEventData;
  String customType = '';
  String customDescription = '';
  bool _disposed = false;
  String? _selectedImagePath;
 bool _isPrivateShare = false;
  bool _isPublicShare = false;


List<String> _getAvailableImagesForEventType() {
  String currentEventType = '';
  
  if (selectedEventData != null) {
    currentEventType = isTypeArabic ? selectedEventData!.nomAr : selectedEventData!.nomFr;
  } else if (customType.isNotEmpty) {
    currentEventType = customType;
  }
  
  if (currentEventType.isEmpty) {
    return availableImages;
  }
  
  return imagesByEventType[currentEventType] ?? availableImages;
}

void _showImagePicker() {
  final availableImages = _getAvailableImagesForEventType();
  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          selectedEventData != null || customType.isNotEmpty 
            ? 'Images pour ${selectedEventData != null ? (isTypeArabic ? selectedEventData!.nomAr : selectedEventData!.nomFr) : customType}'
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
                    if (selectedEventData != null || customType.isNotEmpty)
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
          if (selectedEventData != null || customType.isNotEmpty)
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
  @override
  void initState() {
    super.initState();
    _loadStoredEvents();
  }

  @override
  void dispose() {
    _disposed = true;
    _priceController.dispose();
     _AddresseController.dispose();
    _descriptionController.dispose();
    _nameController.dispose();
    super.dispose();
  }

 Future<void> _loadStoredEvents() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final eventsJson = prefs.getString('events'); 
    
    if (eventsJson != null && mounted) {
      final List<dynamic> decodedEvents = json.decode(eventsJson);
      setState(() {
        recentEvents = decodedEvents
            .map((eventJson) => EventDataEntity.fromJson(eventJson)) 
            .toList();
        recentEvents.sort((a, b) => b.createdAt.compareTo(a.createdAt)); 
        filteredRecentEvents = List.from(recentEvents);
      });
    }
  } catch (e) {
    print('Erreur lors du chargement des événements: $e');
  }
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

    // Here you would implement the actual sharing logic
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

    // Reset share options after sharing
    setState(() {
      _isPrivateShare = false;
      _isPublicShare = false;
    });
  }
 Future<void> _saveEvents() async {

  try {
    final prefs = await SharedPreferences.getInstance();
    final eventsJson = json.encode(recentEvents.map((e) => e.toJson()).toList());
    await prefs.setString('events', eventsJson); 
    print(eventsJson);
  } catch (e) {
    print('Erreur lors de la sauvegarde des événements: $e');
  }
}

  void _filterEvents(String query) {
    if (mounted) {
      setState(() {
        if (query.isEmpty) {
          filteredRecentEvents = List.from(recentEvents);
        } else {
          filteredRecentEvents = recentEvents
              .where((event) => 
               
                  event.type.toLowerCase().contains(query.toLowerCase()))
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

 Future<void> _addToRecentEvents() async {
 
  String eventType = '';
  String eventDescription = '';
  
  if (selectedEventData != null) {
    eventType = isTypeArabic ? selectedEventData!.nomAr : selectedEventData!.nomFr;
    eventDescription = isDescriptionArabic ? selectedEventData!.descriptionAr : selectedEventData!.descriptionFr;
  } else {
    eventType = customType;
    eventDescription = customDescription.isNotEmpty ? customDescription : _descriptionController.text.trim();
  }
  
  if ( eventDate != null && eventType.isNotEmpty) {
 
    final String eventId = DateTime.now().millisecondsSinceEpoch.toString();
    

    final newEvent = EventDataEntity(
      id: eventId,
      date: eventDate!,
      type: eventType,
      description: eventDescription,
       Addresse: _AddresseController.text.trim(),
      price: isEventPaid ? _priceController.text.trim() : "Gratuit",
      category: option1,
      level: option2,
      participationType: participationType,
      imagePath: _selectedImagePath,
      startTime: startTime, 
      endTime: endTime, 
      classeConcernee: classeConcernee,
      isEventPaid: isEventPaid, 
      isPrivateShare: _isPrivateShare, 
      isPublicShare: _isPublicShare, 
      createdAt: DateTime.now(), 
    ); 
  
    if (mounted) {
      setState(() {
        recentEvents.insert(0, newEvent);
        if (recentEvents.length > 50) {
          recentEvents = recentEvents.take(50).toList();
        }
        filteredRecentEvents = List.from(recentEvents);
      });
      
      await _saveEvents();
    }
  }
}

  Future<void> _deleteEvent(int index) async {
    if (mounted) {
      setState(() {
        final eventToDelete = filteredRecentEvents[index];
        recentEvents.removeWhere((event) => 
        
            event.date == eventToDelete.date);
        filteredRecentEvents.removeAt(index);
      });
      await _saveEvents();
    }
  }

void _loadEventToForm(EventDataEntity event) {
  if (mounted) {
    // Trouver l'EventData correspondant
    EventData? matchingEventData;
    for (var eventData in eventDataList) {
      if (eventData.nomAr == event.type || eventData.nomFr == event.type) {
        matchingEventData = eventData;
        break;
      }
    }

    setState(() {
      if (matchingEventData != null) {
        selectedEventData = matchingEventData;
        customType = '';
        customDescription = '';
        isTypeArabic = matchingEventData.nomAr == event.type;
        isDescriptionArabic = matchingEventData.descriptionAr == event.description;
      } else {
        selectedEventData = null;
        customType = event.type;
        customDescription = event.description;
        _descriptionController.text = customDescription;
      }
  
    
      participationType = event.participationType;
      _selectedImagePath = event.imagePath;
      eventDate = event.date;
      startTime = event.startTime; // Ajouter startTime
      endTime = event.endTime; // Ajouter endTime
      classeConcernee = event.classeConcernee; // Ajouter classeConcernee
      isEventPaid = event.isEventPaid; // Ajouter isEventPaid
      _isPrivateShare = event.isPrivateShare; // Ajouter isPrivateShare
      _isPublicShare = event.isPublicShare; 
     _AddresseController.text = event.Addresse ?? '';
    });
    
    
  }
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

  void _showCustomTypeDialog() {
    String tempType = customType;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Type d\'événement personnalisé'),
          content: TextField(
            controller: TextEditingController(text: tempType),
            onChanged: (value) => tempType = value,
            decoration: const InputDecoration(
              hintText: 'Entrez le type d\'événement',
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
                    selectedEventData = null;
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

  Widget _buildTimeSelector({
    required String label,
    required TimeOfDay? selectedTime,
    required Function(TimeOfDay?) onTimeSelected,
    required bool isRequired,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, isRequired: isRequired),
        InkWell(
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: selectedTime ?? TimeOfDay.now(),
            );
            onTimeSelected(time);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time, color: Colors.grey[600]),
                const SizedBox(width: 12),
                Text(
                  selectedTime == null
                      ? "Sélectionner l'heure"
                      : selectedTime!.format(context),
                  style: TextStyle(
                    color: selectedTime == null ? Colors.grey[500] : Colors.black87,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEventTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _buildLabel("Type d'événement", isRequired: true)),
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
            "Type d'événement",
            "Sélectionnez le type d'événement",
          ),
          value: _getSelectedTypeValue(),
          validator: (value) {
            if ((selectedEventData == null && customType.isEmpty)) {
              return 'Veuillez sélectionner un type d\'événement';
            }
            return null;
          },
          items: [
            ...eventDataList.map((eventData) {
              String displayText = isTypeArabic ? eventData.nomAr : eventData.nomFr;
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
                  selectedEventData = null;
                });
              }
              _showCustomTypeDialog();
            } else if (value != null) {
              if (mounted) {
                setState(() {
                  selectedEventData = eventDataList.firstWhere(
                    (data) => (isTypeArabic ? data.nomAr : data.nomFr) == value,
                  );
                  customType = '';
                });
              }
            }
          },
        ),
        if (selectedEventData == null && customType.isNotEmpty)
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
    if (selectedEventData != null) {
      return isTypeArabic ? selectedEventData!.nomAr : selectedEventData!.nomFr;
    } else if (customType.isNotEmpty) {
      return null; // Aucune valeur sélectionnée dans la dropdown pour les types personnalisés
    }
    return null;
  }

Widget _buildDurationDisplay() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildLabel("Durée", isRequired: false),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.timer, color: Colors.grey[600]),
            const SizedBox(width: 12),
            Text(
              _calculateDuration(),
              style: TextStyle(
                color: _getDurationColor(),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

String _calculateDuration() {
  if (startTime == null || endTime == null) {
    return "-- h --";
  }

  int startMinutes = startTime!.hour * 60 + startTime!.minute;
  int endMinutes = endTime!.hour * 60 + endTime!.minute;

  if (endMinutes < startMinutes) {
    endMinutes += 24 * 60;
  }

  int durationMinutes = endMinutes - startMinutes;
  
  if (durationMinutes <= 0) {
    return "Invalide";
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

Color _getDurationColor() {
  if (startTime == null || endTime == null) {
    return Colors.grey[500]!;
  }

  int startMinutes = startTime!.hour * 60 + startTime!.minute;
  int endMinutes = endTime!.hour * 60 + endTime!.minute;
  
  if (endMinutes < startMinutes) {
    endMinutes += 24 * 60;
  }

  int durationMinutes = endMinutes - startMinutes;

  if (durationMinutes <= 0) {
    return Colors.red;
  } else if (durationMinutes <= 30) {
    return Colors.orange;
  } else if (durationMinutes <= 120) {
    return Colors.green;
  } else if (durationMinutes <= 480) {
    return Colors.blue;
  } else {
    return Colors.purple;
  }
}
  String _selectedFont = 'Default';


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
              items: availableFonts.map((font) {
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
      if (selectedEventData != null)
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
                      ? selectedEventData!.descriptionAr 
                      : selectedEventData!.descriptionFr,
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
                if (selectedEventData == null && 
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
  
  if (selectedEventData != null) {
    tempDescription = isDescriptionArabic 
        ? selectedEventData!.descriptionAr 
        : selectedEventData!.descriptionFr;
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
                          items: availableFonts.map((font) {
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
                      selectedEventData = null;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Créer un Événement",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => EventsPage()),
            );
          },
        ),
        actions: [
          if (recentEvents.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Effacer tous les événements'),
                      content: const Text('Êtes-vous sûr de vouloir supprimer tous les événements récents ?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Annuler'),
                        ),
                        TextButton(
                          onPressed: () async {
                            if (mounted) {
                              setState(() {
                                recentEvents.clear();
                                filteredRecentEvents.clear();
                              });
                            }
                            await _saveEvents();
                            Navigator.of(context).pop();
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Tous les événements ont été supprimés'),
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
                            'Événements récents',
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
                              '${recentEvents.length}',
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
                        onChanged: _filterEvents,
                        decoration: _roundedInputDecoration(
                          "",
                          "Rechercher des événements...",
                          prefixIcon: Icons.search,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: filteredRecentEvents.isEmpty 
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.event_note, size: 48, color: Colors.grey[400]),
                            const SizedBox(height: 8),
                            Text(
                              recentEvents.isEmpty 
                                ? 'Aucun événement créé'
                                : 'Aucun événement trouvé',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            if (recentEvents.isEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'Créez votre premier événement !',
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
                        itemCount: filteredRecentEvents.length,
                        itemBuilder: (context, index) {
                          final event = filteredRecentEvents[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                            
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _formatDate(event.date),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    event.type,
                                    style: TextStyle(
                                      color: Colors.blue[700],
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              leading: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: index == 0 && recentEvents.indexOf(event) == 0 
                                    ? Colors.green 
                                    : Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              trailing: PopupMenuButton<String>(
                                iconSize: 16,
                                onSelected: (value) async {
                                  if (value == 'load') {
                                    _loadEventToForm(event);
                                  } else if (value == 'delete') {
                                    await _deleteEvent(index);
                                    
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
                              onTap: () => _loadEventToForm(event),
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
                          _buildEventTypeSelector(),
                          
                          const SizedBox(height: 16),
                          _buildDescriptionField(),

                          const SizedBox(height: 16),
                          const SizedBox(height: 16),
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    _buildLabel("Adresse de l'événement", isRequired: true),
    TextFormField(
      controller: _AddresseController,
      decoration: _roundedInputDecoration(
        "Adresse",
        "Entrez l'adresse complète de l'événement",
        prefixIcon: Icons.location_on,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Veuillez saisir une adresse';
        }
        return null;
      },
      maxLines: 2,
    ),
  ],
),
                        ],
                        icon: Icons.info_outline,
                      ),

                      _buildSectionCard(
                        "Date et horaires",
                        [
                          _buildLabel("Date de l'événement", isRequired: true),
                          InkWell(
                            onTap: () async {
                              final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                              );
                              if (pickedDate != null && mounted) {
                                setState(() => eventDate = pickedDate);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today, color: Colors.grey[600]),
                                  const SizedBox(width: 12),
                                  Text(
                                    eventDate == null
                                        ? "Sélectionner une date"
                                        : "${eventDate!.day}/${eventDate!.month}/${eventDate!.year}",
                                    style: TextStyle(
                                      color: eventDate == null ? Colors.grey[500] : Colors.black87,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                         // Dans la section "Date et horaires", remplacer la Row existante par :
Row(
  children: [
    Expanded(
      child: _buildTimeSelector(
        label: "Heure de début",
        selectedTime: startTime,
        onTimeSelected: (time) {
          if (mounted) {
            setState(() => startTime = time);
          }
        },
        isRequired: true,
      ),
    ),
    const SizedBox(width: 16),
    Expanded(
      child: _buildTimeSelector(
        label: "Heure de fin",
        selectedTime: endTime,
        onTimeSelected: (time) {
          if (mounted) {
            setState(() => endTime = time);
          }
        },
        isRequired: true,
      ),
    ),
    const SizedBox(width: 16),
    Expanded(
      child: _buildDurationDisplay(),
    ),
  ],
),



                        ],
                        icon: Icons.schedule,
                      ),

                   _buildSectionCard(
  "Mode de participation",
  [
    _buildLabel("Type de participation", isRequired: true),
    Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              if (mounted) {
                setState(() => participationType = true);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: participationType ? Colors.blue.withOpacity(0.1) : Colors.grey[50],
                border: Border.all(
                  color: participationType ? Colors.blue : Colors.grey[300]!,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    participationType ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: participationType ? Colors.blue : Colors.grey,
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.family_restroom, color: Colors.grey),
                  const SizedBox(width: 8),
                  const Text("Avec parent"),
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
                setState(() => participationType = false);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: !participationType ? Colors.blue.withOpacity(0.1) : Colors.grey[50],
                border: Border.all(
                  color: !participationType ? Colors.blue : Colors.grey[300]!,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    !participationType ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: !participationType ? Colors.blue : Colors.grey,
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.person, color: Colors.grey),
                  const SizedBox(width: 8),
                  const Text("Sans parent"),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
    const SizedBox(height: 20),
    _buildLabel("Mode de paiement", isRequired: true),
    Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              if (mounted) {
                setState(() => isEventPaid = false);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: !isEventPaid ? Colors.green.withOpacity(0.1) : Colors.grey[50],
                border: Border.all(
                  color: !isEventPaid ? Colors.green : Colors.grey[300]!,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    !isEventPaid ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: !isEventPaid ? Colors.green : Colors.grey,
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
                setState(() => isEventPaid = true);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isEventPaid ? Colors.orange.withOpacity(0.1) : Colors.grey[50],
                border: Border.all(
                  color: isEventPaid ? Colors.orange : Colors.grey[300]!,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    isEventPaid ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: isEventPaid ? Colors.orange : Colors.grey,
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
    if (isEventPaid) ...[
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
                    if (isEventPaid && (value == null || value.trim().isEmpty)) {
                      return 'Le prix est requis pour un événement payant';
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
  icon: Icons.people,
),

                   _buildSectionCard(
  "Classe concernée",
  [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Classe concernée"),
        DropdownButtonFormField<String>(
          value: classeConcernee,
          decoration: _roundedInputDecoration(
            "Classe concernée",
            "Sélectionnez une classe",
          ),
          items: const [
            DropdownMenuItem(value: "Classe 1", child: Text("Classe 1")),
            DropdownMenuItem(value: "Classe 2", child: Text("Classe 2")),
            DropdownMenuItem(value: "Classe 3", child: Text("Classe 3")),
          ],
          onChanged: (value) {
            if (mounted) {
              setState(() => classeConcernee = value);
            }
          },
        ),
      ],
    ),
  ],
  icon: Icons.school,
),

                      const SizedBox(height: 32),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                           const SizedBox(width: 16),
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
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => EventsPage()),
                            ),
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
                                if (eventDate == null) {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Veuillez sélectionner une date'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                  return;
                                }
                                
                                if (startTime == null || endTime == null) {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Veuillez sélectionner les heures de début et de fin'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                  return;
                                }
                                
                                await _addToRecentEvents();
                                
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          const Icon(Icons.check_circle, color: Colors.white),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text('Événement "${_nameController.text}" créé et sauvegardé !'),
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
                                  
                                  _formKey.currentState!.reset();
                                  setState(() {
                                    selectedEvent = null;
                                    selectedEventData = null;
                                    customType = '';
                                    customDescription = '';
                                    startTime = null;
                                    endTime = null;
                                    eventDate = null;
                                    participationType = true;
                                    option1 = null;
                                    option2 = null;
                                    _selectedImagePath = null;
                                    isTypeArabic = false;
                                    isDescriptionArabic = false;
                                  });
                                  _nameController.clear();
                                  _descriptionController.clear();
                                   _AddresseController.clear();
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
                                  "Créer l'événement",
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
  }
}