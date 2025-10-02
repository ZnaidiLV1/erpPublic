import 'package:flutter/material.dart';

class NameAvatar extends StatelessWidget {
  final String fullName;
  final double size;

  NameAvatar({required this.fullName, this.size = 50});

  Color _generateColor(String text) {
    final int hash = text.codeUnits.fold(0, (prev, element) => prev + element);
    final List<Color> colors = [
      Colors.blue, Colors.green, Colors.orange, Colors.red, Colors.purple, Colors.teal
    ];
    return colors[hash % colors.length];
  }

  String _getInitials(String name) {
    List<String> parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length > 1) {
      return "${parts[0][0]}${parts[1][0]}".toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: _generateColor(fullName),
      child: Text(
        _getInitials(fullName),
        style: TextStyle(color: Colors.white, fontSize: size * 0.4, fontWeight: FontWeight.bold),
      ),
    );
  }
}
