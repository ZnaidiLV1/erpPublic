// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseModel _$ExpenseModelFromJson(Map<String, dynamic> json) => ExpenseModel(
      id: (json['id'] as num?)?.toInt(),
      category: json['category'] as String?,
      subCategory: json['subCategory'] as String?,
      details: json['details'] as String?,
      ammount: json['ammount'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
    );

Map<String, dynamic> _$ExpenseModelToJson(ExpenseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'subCategory': instance.subCategory,
      'details': instance.details,
      'ammount': instance.ammount,
      'date': instance.date,
      'time': instance.time,
    };
