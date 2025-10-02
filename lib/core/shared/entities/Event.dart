import 'package:flutter/material.dart';

class Event {
  final String title;
  final String type;
  final DateTime date;
  final TimeOfDay time;

  Event(this.title, this.type, this.date, this.time);
}

final List<Event> events = [
  Event('Réunion', 'meeting', DateTime(2025, 2, 5), TimeOfDay(hour: 10, minute: 30)),
  Event('Conférence', 'conference', DateTime(2025, 2, 10), TimeOfDay(hour: 14, minute: 0)),
  Event('Anniversaire', 'birthday', DateTime(2025, 2, 15), TimeOfDay(hour: 19, minute: 45)),
  Event('Atelier', 'workshop', DateTime(2025, 2, 2), TimeOfDay(hour: 9, minute: 15)),
  Event('Séminaire', 'seminar', DateTime(2025, 2, 8), TimeOfDay(hour: 16, minute: 30)),
  Event('Webinaire', 'webinar', DateTime(2025, 2, 12), TimeOfDay(hour: 18, minute: 0)),
];


final Map<String, Color> eventColors = {
  'meeting': Colors.pink,
  'conference': Colors.green,
  'birthday': Colors.orange,
  'workshop': Colors.blue,
  'seminar': Colors.purple,
  'webinar': Colors.teal,
};
