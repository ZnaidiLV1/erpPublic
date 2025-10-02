import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core/components/summary_section_4.dart';
import '../widgets/StatusWidget.dart';
import '../widgets/badge.dart';
import '../widgets/badge_prefer.dart';
import '../widgets/histori_gang.dart';

class BadgesBody extends StatefulWidget {
  final VoidCallback onItemPressed;
  const BadgesBody({super.key, required this.onItemPressed});

  @override
  State<BadgesBody> createState() => _BadgesBodyState();
}

class _BadgesBodyState extends State<BadgesBody> {
  @override
  Widget build(BuildContext context) {
    final performanceData = [
      PerformanceData(
        title: 'Participation',
        color: const Color(0xFF6ECCC0),
        percentage: 90,
      ),
      PerformanceData(
        title: 'Comportement',
        color: const Color(0xFF0A215A),
        percentage: 50,
      ),
      PerformanceData(
        title: 'Performance sportive',
        color: const Color(0xFF7BC043),
        percentage: 70,
      ),
      PerformanceData(
        title: 'Compétence lecture',
        color: const Color(0xFFE94D88),
        percentage: 65,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SummarySection4(), // Ajout de SummarySection4 en haut de l'écran
              const SizedBox(height: 16),

              // Première rangée avec StatusWidget et Badges
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: StatusWidget(),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Badges(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Deuxième rangée avec BadgePerformanceChart et HistoriqueGagnantWidget
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: BadgePerformanceChart(
                          performanceData: performanceData),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: HistoriqueGagnantWidget(onItemPressed: widget.onItemPressed,),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}
