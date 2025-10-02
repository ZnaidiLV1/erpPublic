import 'package:flutter/material.dart';

class ClubDataEntity {
  final String id;
  final String type; 
  final String description;
  final String? category;
  final String instructor;
  final int capacity;
  final String? imagePath;
  final String price;
  final bool isPaid;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final String? selectedDay;
  final bool isPrivateShare;
  final bool isPublicShare;
  final DateTime createdAt;
  final List<String> schedule;
  final int? periodInMonths; 
  final List<Map<String, dynamic>>? daySchedules; 
  final String? classeConcernee; 
  final String? adresse; 

  ClubDataEntity({
    required this.id,
    required this.type,
    required this.description,
    this.category,
    required this.instructor,
    required this.capacity,
    this.imagePath,
    required this.price,
    required this.isPaid,
    this.startTime,
    this.endTime,
    this.selectedDay,
    required this.isPrivateShare,
    required this.isPublicShare,
    required this.createdAt,
    List<String>? schedule,
    this.periodInMonths,
    this.daySchedules,
    this.classeConcernee, 
    this.adresse,
  }) : schedule = schedule ?? [];
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'description': description,
      'category': category,
      'instructor': instructor,
      'capacity': capacity,
      'imagePath': imagePath,
      'price': price,
      'isPaid': isPaid,
      'startTime': startTime != null 
          ? {'hour': startTime!.hour, 'minute': startTime!.minute}
          : null,
      'endTime': endTime != null 
          ? {'hour': endTime!.hour, 'minute': endTime!.minute}
          : null,
      'selectedDay': selectedDay,
      'isPrivateShare': isPrivateShare,
      'isPublicShare': isPublicShare,
      'createdAt': createdAt.toIso8601String(),
      'schedule': schedule,
      'periodInMonths': periodInMonths,
      'daySchedules': daySchedules,
      'classeConcernee': classeConcernee, 
      'adresse': adresse,
    };
  }
  factory ClubDataEntity.fromJson(Map<String, dynamic> json) {
    return ClubDataEntity(
      id: json['id']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString(),
      instructor: json['instructor']?.toString() ?? '',
      capacity: json['capacity'] as int? ?? 0,
      imagePath: json['imagePath']?.toString(),
      price: json['price']?.toString() ?? '0',
      isPaid: json['isPaid'] as bool? ?? false,
      startTime: json['startTime'] != null
          ? TimeOfDay(
              hour: json['startTime']['hour'] as int,
              minute: json['startTime']['minute'] as int,
            )
          : null,
      endTime: json['endTime'] != null
          ? TimeOfDay(
              hour: json['endTime']['hour'] as int,
              minute: json['endTime']['minute'] as int,
            )
          : null,
      selectedDay: json['selectedDay']?.toString(),
      isPrivateShare: json['isPrivateShare'] as bool? ?? false,
      isPublicShare: json['isPublicShare'] as bool? ?? false,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      schedule: (json['schedule'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ?? [],
      periodInMonths: json['periodInMonths'] as int?,
      daySchedules: json['daySchedules'] != null 
          ? List<Map<String, dynamic>>.from(json['daySchedules'])
          : null,
      classeConcernee: json['classeConcernee']?.toString(),
      adresse: json['adresse']?.toString(),
    );
  }
  ClubDataEntity copyWith({
    String? id,
    String? type,
    String? description,
    String? category,
    String? instructor,
    int? capacity,
    String? imagePath,
    String? price,
    bool? isPaid,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? selectedDay,
    bool? isPrivateShare,
    bool? isPublicShare,
    DateTime? createdAt,
    List<String>? schedule,
    int? periodInMonths,
    List<Map<String, dynamic>>? daySchedules,
    String? classeConcernee,
    String? adresse, 
  }) {
    return ClubDataEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      description: description ?? this.description,
      category: category ?? this.category,
      instructor: instructor ?? this.instructor,
      capacity: capacity ?? this.capacity,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      isPaid: isPaid ?? this.isPaid,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      selectedDay: selectedDay ?? this.selectedDay,
      isPrivateShare: isPrivateShare ?? this.isPrivateShare,
      isPublicShare: isPublicShare ?? this.isPublicShare,
      createdAt: createdAt ?? this.createdAt,
      schedule: schedule ?? this.schedule,
      periodInMonths: periodInMonths ?? this.periodInMonths,
      daySchedules: daySchedules ?? this.daySchedules,
      classeConcernee: classeConcernee ?? this.classeConcernee, 
      adresse: adresse ?? this.adresse, 
    );
  }

  @override
  String toString() {
    return 'ClubDataEntity(id: $id, type: $type, instructor: $instructor, period: $periodInMonths mois, classe: $classeConcernee, adresse: $adresse)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ClubDataEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
  String formattedSchedule(BuildContext context) {
    if (selectedDay != null && startTime != null && endTime != null) {
      return '$selectedDay: ${startTime!.format(context)} - ${endTime!.format(context)}';
    }
    return schedule.join(', ');
  }

  String get displayPrice {
    return isPaid ? '$price DT' : 'Gratuit';
  }

  String get formattedDuration {
    if (startTime == null || endTime == null) return "Non défini";
    
    int startMinutes = startTime!.hour * 60 + startTime!.minute;
    int endMinutes = endTime!.hour * 60 + endTime!.minute;
    
    if (endMinutes < startMinutes) {
      endMinutes += 24 * 60;
    }
    
    int durationMinutes = endMinutes - startMinutes;
    
    if (durationMinutes <= 0) return "Invalide";
    
    int hours = durationMinutes ~/ 60;
    int minutes = durationMinutes % 60;
    
    if (hours == 0) {
      return "$minutes min";
    } else if (minutes == 0) {
      return "$hours h";
    } else {
      return "$hours h $minutes min";
    }
  }

  String get formattedPeriod {
    if (periodInMonths == null) return "Non définie";
    if (periodInMonths == 1) return "1 mois";
    return "$periodInMonths mois";
  }

  String get formattedDaySchedules {
    if (daySchedules == null || daySchedules!.isEmpty) {
      return formattedSchedule(NavigatorState().context);
    }
    
    return daySchedules!.map((ds) {
      final day = ds['day'];
      final startTime = TimeOfDay(
        hour: ds['startTime']['hour'],
        minute: ds['startTime']['minute'],
      );
      final endTime = TimeOfDay(
        hour: ds['endTime']['hour'], 
        minute: ds['endTime']['minute'],
      );
      
      return '$day: ${startTime.format(NavigatorState().context)} - ${endTime.format(NavigatorState().context)}';
    }).join('\n');
  }
  String getTotalWeeklyDuration() {
    if (daySchedules == null || daySchedules!.isEmpty) {
      return formattedDuration;
    }
    
    int totalMinutes = 0;
    
    for (var ds in daySchedules!) {
      final startTime = TimeOfDay(
        hour: ds['startTime']['hour'],
        minute: ds['startTime']['minute'],
      );
      final endTime = TimeOfDay(
        hour: ds['endTime']['hour'],
        minute: ds['endTime']['minute'],
      );
      
      int startMinutes = startTime.hour * 60 + startTime.minute;
      int endMinutes = endTime.hour * 60 + endTime.minute;
      
      if (endMinutes < startMinutes) {
        endMinutes += 24 * 60;
      }
      
      totalMinutes += (endMinutes - startMinutes);
    }
    
    if (totalMinutes <= 0) return "Invalide";
    
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
  int get weeklyDaysCount {
    if (daySchedules == null || daySchedules!.isEmpty) {
      return selectedDay != null ? 1 : 0;
    }
    return daySchedules!.length;
  }
  String get formattedClasseConcernee {
    return classeConcernee ?? "Non spécifiée";
  }

  String get formattedAdresse {
    return adresse ?? "Adresse non spécifiée";
  }

  bool get hasLocation {
    return adresse != null && adresse!.trim().isNotEmpty;
  }

  bool get hasTargetClass {
    return classeConcernee != null && classeConcernee!.trim().isNotEmpty;
  }
}