import 'package:biboo_pro/core/components/today_widget.dart';
import 'package:flutter/material.dart';

import '../../presentation/progess/widgets/widget_state.dart';

class SummarySection3 extends StatefulWidget {
  const SummarySection3({super.key});

  @override
  State<SummarySection3> createState() => _SummarySection3State();
}

class _SummarySection3State extends State<SummarySection3> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left widget - no Expanded
            TodayWidget(),

            // Right widget
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: ProgressionWidget(),
            ),
          ],
        );
      },
    );
  }
}
