import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/components/summary_section_2.dart';
import '../../../core/constants/colors.dart';
import '../../../core/shared/entities/summaryItem.dart';
import 'absence_chart.dart';
import 'absence_data_table.dart';
import 'absence_pie_chart.dart';

class AbsenceDetails extends StatelessWidget {
  final VoidCallback onCancelPressed;

  const AbsenceDetails({super.key, required this.onCancelPressed});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        SummarySection2(
          items: [
            SummaryItem(
              label: 'Enfants',
              value: 80,
              icon: Iconsax.people,
              color: HexColor("#70C4CF"),
            ),
            SummaryItem(
              label: 'Absent',
              value: 2,
              icon: Iconsax.task_square,
              color: HexColor("#FB7D5B"),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: IconButton(
                  onPressed: onCancelPressed, icon: const Icon(Icons.close)),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 500,
              child: AbsenceChart(),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Absence",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 70,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 60,
                    ),
                    AbsencePieChart(value: 35),
                  ],
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Text(
                "Aperçu des absences",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: HexColor("#252C58")),
              ),
              const Spacer()
            ],
          ),
        ),
        const SizedBox(height: 10,),
        AbsenceDataTable(onItemPressed: () {  },)
      ],
    );
  }
}
