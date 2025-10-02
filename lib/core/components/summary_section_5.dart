import 'package:biboo_pro/core/components/today_widget.dart';
import 'package:flutter/material.dart';

import '../../presentation/finance/widgets/app_bar_finance.dart';

class SummarySection5 extends StatefulWidget {
  const SummarySection5({super.key});

  @override
  State<SummarySection5> createState() => _SummarySection5State();
}

class _SummarySection5State extends State<SummarySection5> {
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
              child: AppFinancesWidget(),
            ),
          ],
        );
      },
    );
  }
}
