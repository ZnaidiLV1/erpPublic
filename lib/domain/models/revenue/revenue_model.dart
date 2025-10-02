import 'package:json_annotation/json_annotation.dart';

part 'revenue_model.g.dart';

@JsonSerializable()
class RevenueModel {
  final int? id;
  final String? category;
  final String? subCategory;
  final String? details;
  final String? ammount;
  final String? date;
  final String? time;

  const RevenueModel(
      {
        required this.id,
        required this.category,
        required this.subCategory,
        required this.details,
        required this.ammount,
        required this.date,
        required this.time});

  factory RevenueModel.fromJson(Map<String, Object?> json) =>
      _$RevenueModelFromJson(json);



  Map<String, Object?> toJson() => _$RevenueModelToJson(this);
}