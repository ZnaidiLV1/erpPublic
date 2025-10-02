import 'package:flutter/cupertino.dart';

class SummaryItem {
  final String label;
  final int value;
  final IconData icon;
  final Color color;

  SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });
}