import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/colors.dart';
import '../../../core/shared/entities/Event.dart';

class EventsList extends StatelessWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Evénéments à venir",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Text(
                "voir tous",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: HexColor("#0077FF")),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 300,
          width: 300,
          child: ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              Event event = events[index];
              Color eventColor = eventColors[event.type] ?? Colors.grey;
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: eventCard(eventColor, event),
              );
            },
          ),
        ),
      ],
    );
  }
}

Widget eventCard(Color color, Event event) {
  return Container(
    width: 300,
    height: 100,
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(50)),
          child: Text(
            event.date.day.toString(),
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              overflow: TextOverflow.ellipsis,
              event.title,
              style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
            Text(
              overflow: TextOverflow.ellipsis,
              "${DateFormat("d MMMM yyyy", 'fr_FR').format(event.date)} / "
                  "${_formatTime(event.time)} - ${_formatTime(event.time.replacing(hour: event.time.hour + 1))}",
              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 10, color: HexColor("#8A8A8A")),
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              event.type,
              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 10, color: HexColor("#8A8A8A")),
            ),
            // Text(data),
          ],
        ),
        const Icon(Icons.arrow_forward_ios, size: 12,)
      ],
    ),
  );
}

String _formatTime(TimeOfDay time) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return DateFormat('h:mm a', 'fr_FR').format(dt); // Example: 8:00 AM
}


