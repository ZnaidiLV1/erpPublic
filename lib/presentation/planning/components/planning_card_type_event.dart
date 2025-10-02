import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/shared/entities/planningItem.dart';

class PlanningCardTypeEvent extends StatelessWidget {
  final PlanningItem event;
  const PlanningCardTypeEvent({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('${event.title} ' ?? '', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600 ,color: HexColor("#303972")),),
            Text('${event.subtitle} ' ?? '', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400 ,color: HexColor("#303972")),),
            Text(event.note ?? '', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600 ,color: HexColor("#4D44B5")),),
          ],
        ),
        const SizedBox(height: 20,),
        Container(
          height: 160,
          width: 280,
          margin: const EdgeInsets.only(left: 30),
          decoration: BoxDecoration(
            color: HexColor("#C1BBEB"),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    );
  }
}
