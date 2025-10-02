import 'package:flutter/material.dart';

class EventDataEntity {
  final String id;
  final DateTime date;
  final String type;
  final String description;
  final String price;
  final String? category;
  final String? level;
  final bool participationType;
  final String? imagePath;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final String? classeConcernee;
  final String? Addresse;
  final bool isEventPaid;
  final bool isPrivateShare;
  final bool isPublicShare;
  final DateTime createdAt;

EventDataEntity({
    required this.id,
    required this.date,
    required this.type,
    required this.description,
    required this.price,
      required  this.Addresse,
    this.category,
    this.level,
    required this.participationType,
    this.imagePath,
    this.startTime,
    this.endTime,
    this.classeConcernee,
    required this.isEventPaid,
    this.isPrivateShare = false,
    this.isPublicShare = false,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'type': type,
      'description': description,
      'price': price,
       'Addresse': Addresse,
      'category': category,
      'level': level,
      'participationType': participationType,
      'imagePath': imagePath,
      'startTime': startTime != null ? '${startTime!.hour}:${startTime!.minute}' : null,
      'endTime': endTime != null ? '${endTime!.hour}:${endTime!.minute}' : null,
      'classeConcernee': classeConcernee,
      'isEventPaid': isEventPaid,
      'isPrivateShare': isPrivateShare,
      'isPublicShare': isPublicShare,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory EventDataEntity.fromJson(Map<String, dynamic> json) {
    return EventDataEntity(
      id: json['id'] ?? '',
      date: DateTime.parse(json['date']),
      type: json['type'] ?? '',
      description: json['description'] ?? '',
       Addresse: json['Addresse'] ?? '',
      price: json['price'] ?? '',
      category: json['category'],
      level: json['level'],
      participationType: json['participationType'] ?? true,
      imagePath: json['imagePath'],
      startTime: json['startTime'] != null ? _parseTime(json['startTime']) : null,
      endTime: json['endTime'] != null ? _parseTime(json['endTime']) : null,
      classeConcernee: json['classeConcernee'],
      isEventPaid: json['isEventPaid'] ?? false,
      isPrivateShare: json['isPrivateShare'] ?? false,
      isPublicShare: json['isPublicShare'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  static TimeOfDay? _parseTime(String timeString) {
    try {
      final parts = timeString.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    } catch (e) {
      return null;
    }
  }
}
