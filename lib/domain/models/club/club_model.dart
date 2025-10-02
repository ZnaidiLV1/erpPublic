import 'package:json_annotation/json_annotation.dart';

part 'club_model.g.dart';

@JsonSerializable()
class ClubModel {
  final int? id;
  final String title;
  final String imageUrl;
  final String instructor;
  final String price;
  final String capacity;
  final String category;
  final String description;
  final List<String> schedule;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isActive;

  const ClubModel({
    this.id,
    required this.title,
    required this.imageUrl,
    required this.instructor,
    required this.price,
    required this.capacity,
    required this.category,
    required this.description,
    required this.schedule,
    this.startDate,
    this.endDate,
    this.isActive = true,
  });

  factory ClubModel.fromJson(Map<String, dynamic> json) =>
      _$ClubModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClubModelToJson(this);

  // Helper method to get price as double
  double get priceAsDouble {
    final priceStr = price.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(priceStr) ?? 0.0;
  }

  // Helper method to get capacity as int
  int get capacityAsInt {
    final capacityStr = capacity.replaceAll(RegExp(r'[^\d]'), '');
    return int.tryParse(capacityStr) ?? 0;
  }
}

