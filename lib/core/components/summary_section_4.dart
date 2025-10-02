import 'package:biboo_pro/core/components/today_widget.dart';
import 'package:flutter/material.dart';

import '../../presentation/badeges/widgets/widget_appbar_badgets.dart';

class SummarySection4 extends StatefulWidget {
  const SummarySection4({super.key});

  @override
  State<SummarySection4> createState() => _SummarySection4State();
}

class _SummarySection4State extends State<SummarySection4> {
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
              child: ProBadgetsWidget(),
            ),
          ],
        );
      },
    );
  }
}
