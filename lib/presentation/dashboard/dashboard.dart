import 'package:flutter/material.dart';
import '../../core/components/calandrie.dart';
import '../../core/components/summary_section.dart';
import '../../core/constants/colors.dart';
import '../../core/shared/entities/summaryItem.dart';
import 'components/event_list.dart';
import 'components/overview_chart.dart';
import 'components/pie_chart.dart';
import 'components/review_chart.dart';
import 'components/top_student_list.dart';


class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        SummarySection(
          items: [
            SummaryItem(
                label: 'Enfants',
                value: 12,
                icon: Icons.person,
                color: HexColor("#3D5EE1")),
            SummaryItem(
                label: 'Animatrice',
                value: 12,
                icon: Icons.location_history,
                color: HexColor("#FB7D5B")),
            SummaryItem(
                label: 'Events',
                value: 40,
                icon: Icons.calendar_month,
                color: HexColor("#FCC43E")),
            SummaryItem(
                label: 'Food',
                value: 32,
                icon: Icons.fastfood,
                color: HexColor("#70C4CF")),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [CalendarSection(), OverViewChart()],
        ),
         const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            EventsList(),
            PieChartSample2(),
            TopStudentsList(),
          ],
        ),
        ReviewChart()
      ],
    );
  }
}
