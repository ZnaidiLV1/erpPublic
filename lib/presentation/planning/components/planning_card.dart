import 'package:biboo_pro/presentation/planning/components/planning_card_type_auther.dart';
import 'package:biboo_pro/presentation/planning/components/planning_card_type_event.dart';
import 'package:biboo_pro/presentation/planning/components/planning_card_type_reminder.dart';

import '../../../core/shared/entities/planningItem.dart';
import 'package:flutter/material.dart';

Widget planningCard(PlanningItem item){
  if(item.type == PlanningType.Event){
    return PlanningCardTypeEvent(event: item);
  }
  else if (item.type == PlanningType.Reminder){
    return PlanningCardTypeReminder(event: item);
  }
  else if (item.type == PlanningType.Auther){
    return PlanningCardTypeOther(event: item);
  }
  else{
    return const SizedBox();
  }
}