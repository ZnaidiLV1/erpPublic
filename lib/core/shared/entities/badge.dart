import 'dart:ui';

import '../../constants/colors.dart';

class StudentBadge {
  final String fullName;
  final double points;

  StudentBadge({required this.fullName, required this.points});

  Color? getcolor() {
    if (points >= 9) {
      return badgeColor["gold"];
    } else if (points >= 8) {
      return badgeColor["silver"];
    } else if (points >= 7) {
      return badgeColor["bronze"];
    } else if (points >= 6) {
      return badgeColor["iron"];
    } else {
      return null;
    }
  }

  String? getImage() {
    if (points >= 9) {
      return "assets/images/badge_1.png";
    } else if (points >= 8) {
      return "assets/images/badge_2.png";
    } else if (points >= 7) {
      return "assets/images/badge_3.png";
    } else {
      return null;
    }
  }
}

final Map<String, Color> badgeColor = {
  'gold': HexColor("#FFD700"),
  'silver': HexColor("#C0C0C0"),
  'bronze': HexColor("#D9AB7D"),
  'iron': HexColor("#F0F7FF"),
};

final List<StudentBadge> badges = [
  StudentBadge(fullName: "Joshua Ashiru", points: 9.6), // Gold
  StudentBadge(fullName: "Adeola Ayo", points: 9), // Gold
  StudentBadge(fullName: "Olawuyi Tobi", points: 8.5), // Silver
  StudentBadge(fullName: "Mayowa Ade", points: 7), // Bronze
  StudentBadge(fullName: "Mayowa Ade", points: 6.5), // Iron
];
