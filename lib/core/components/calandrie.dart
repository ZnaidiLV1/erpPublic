import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../constants/colors.dart';
import '../shared/entities/Event.dart';
class CalendarSection extends StatefulWidget {
  const CalendarSection({super.key});

  @override
  _CalendarSectionState createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  late DateTime _selectedDay;
  late DateTime _focusedDay;



  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr_FR');
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events.where((event) =>
        isSameDay(event.date, day)
    ).toList();
  }




  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Calendar",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  DateFormat.yMMMM().format(_focusedDay),
                  style: TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w600,
                      color: HexColor("#8A8A8A")),
                ),
              ],
            ),
          ),
          TableCalendar<Event>(
            locale: 'fr_FR',
            firstDay: DateTime.utc(2020, 01, 01),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: _focusedDay,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            headerVisible: false,
            rowHeight: 40,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedEvents.value = _getEventsForDay(selectedDay);
              });
            },
            calendarStyle: CalendarStyle(
              todayTextStyle: const TextStyle(color: Colors.black),
              todayDecoration: BoxDecoration(
                color: HexColor("#F0F7FF"),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: HexColor("#70C4CF"),
                //border: Border.all(color: Colors.orange, width: 2),
                shape: BoxShape.circle,
              ),
              selectedTextStyle: const TextStyle(color: Colors.black),
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
                        style: const TextStyle(
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
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: eventColors[event.type] ?? Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            event.title,
                            style: const TextStyle(color: Colors.white),
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


