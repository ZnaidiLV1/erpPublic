// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubModel _$ClubModelFromJson(Map<String, dynamic> json) => ClubModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      instructor: json['instructor'] as String,
      price: json['price'] as String,
      capacity: json['capacity'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      schedule:
          (json['schedule'] as List<dynamic>).map((e) => e as String).toList(),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$ClubModelToJson(ClubModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'instructor': instance.instructor,
      'price': instance.price,
      'capacity': instance.capacity,
      'category': instance.category,
      'description': instance.description,
      'schedule': instance.schedule,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isActive': instance.isActive,
    };
