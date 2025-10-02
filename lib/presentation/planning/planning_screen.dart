import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../core/constants/colors.dart';
import '../../core/shared/entities/planningItem.dart';
import 'components/planning_card.dart';

class PlanningScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: planningItems.length,
          itemBuilder: (context, index) {
            final event = planningItems[index];
            String eventDate = DateFormat('EEEE, MMMM dd yyyy').format(event.date);
            return TimelineTile(
              alignment: TimelineAlign.start,
              isFirst: index == 0,
              isLast: index == planningItems.length - 1,
              indicatorStyle: IndicatorStyle(
                  width: 20,
                  color: HexColor("#A098AE"),
                  indicator: Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: HexColor("4D44B5"), width: 4)),
                  )),
              beforeLineStyle:
                  LineStyle(color: HexColor("#A098AE"), thickness: 2),
              endChild: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(eventDate, style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400 ,color: HexColor("#A098AE")),),
                      const SizedBox(height: 10,),
                      planningCard(event),
                    ],
                  )
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


