
import 'package:json_annotation/json_annotation.dart';

part 'expense_model.g.dart';

@JsonSerializable()
class ExpenseModel {
  final int? id;
  final String? category;
  final String? subCategory;
  final String? details;
  final String? ammount;
  final String? date;
  final String? time;

  const ExpenseModel(
      {
        required this.id,
        required this.category,
        required this.subCategory,
        required this.details,
        required this.ammount,
        required this.date,
        required this.time});

  factory ExpenseModel.fromJson(Map<String, Object?> json) =>
      _$ExpenseModelFromJson(json);



  Map<String, Object?> toJson() => _$ExpenseModelToJson(this);
}
