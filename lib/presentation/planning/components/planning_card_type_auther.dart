
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/shared/entities/planningItem.dart';

class PlanningCardTypeOther extends StatelessWidget {
  final PlanningItem event;
  const PlanningCardTypeOther({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${event.title} ' ?? '', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700 ,color: HexColor("#303972")),),
        Text('${event.subtitle} ' ?? '', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400 ,color: HexColor("#303972")),),
        Text(event.note ?? '', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700 ,color: HexColor("#FB7D5B")),),
      ],
    );
  }
}
