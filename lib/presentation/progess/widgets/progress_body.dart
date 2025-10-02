import 'package:biboo_pro/presentation/progess/widgets/tracker_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/components/summary_section_3.dart';
import 'bar_chart.dart';
import 'card_progress.dart';

class ProgressFile extends StatefulWidget {
  const ProgressFile({super.key});

  @override
  State<ProgressFile> createState() => _ProgressFileState();
}

class _ProgressFileState extends State<ProgressFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SummarySection3(), // Ajout de SummarySection3() en haut de l'écran
              const SizedBox(height: 16), // Espacement entre les widgets
              Column(
                children: [
                  SizedBox(height: 271, width: 1095, child: AnalyticsChart())
                ],
              ),
              const SizedBox(height: 16),
              ProgressionFiltersWidget(), // Intégration du widget de filtres
              const SizedBox(height: 16),
              buildProgressBody()
            ],
          ),
        ],
      ),
    );
  }
  Widget buildProgressBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getRowCount(context),
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: 1,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          return ProgressCard();
        },
      ),
    );
  }

  int getRowCount(context) {
    if (MediaQuery.of(context).size.width > 1600) {
      return 5;
    } else if (MediaQuery.of(context).size.width > 1350) {
      return 4;
    } else {
      return 3;
    }
  }
}
