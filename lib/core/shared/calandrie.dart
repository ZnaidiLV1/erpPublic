import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'entities/Event.dart';

class CalendarSection extends StatefulWidget {
  @override
  _CalendarSectionState createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  final Map<DateTime, List<Event>> _events = {
    DateTime.utc(2025, 2, 5): [Event('Réunion', 'meeting', DateTime.utc(2025, 2, 5), TimeOfDay(hour: 10, minute: 30))],
    DateTime.utc(2025, 2, 10): [Event('Conférence', 'conference' , DateTime.utc(2025, 2, 10), TimeOfDay(hour: 14, minute: 0))],
    DateTime.utc(2025, 2, 15): [Event('Anniversaire', 'birthday', DateTime.utc(2025, 2, 15), TimeOfDay(hour: 19, minute: 45))],
  };

  final Map<String, Color> eventColors = {
    'meeting': Colors.pink,
    'conference': Colors.green,
    'birthday': Colors.orange,
  };

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr_FR');
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 420,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TableCalendar<Event>(
            locale: 'fr_FR',
            firstDay: DateTime.utc(2020, 01, 01),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedEvents.value = _getEventsForDay(selectedDay);
              });
            },
            calendarStyle: CalendarStyle(
              todayTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                border: Border.all(color: Colors.orange, width: 2),
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.black),
            ),
            eventLoader: (day) => _getEventsForDay(day),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, focusedDay) {
                List<Event> dayEvents = _getEventsForDay(date);
                if (dayEvents.isNotEmpty) {
                  Color eventColor =
                      eventColors[dayEvents.first.type] ?? Colors.grey;
                  return Center(
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: eventColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${date.day}',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<List<Event>>(
            valueListenable: _selectedEvents,
            builder: (context, events, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: events
                    .map((event) => Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: eventColors[event.type] ?? Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            event.title,
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

