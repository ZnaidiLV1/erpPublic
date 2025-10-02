import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "Analytique",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 250,
              ),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 53, 39, 158),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 16),
              Container(
                child: Text("Nombre de fiche de progression"),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 1095,
            height: 171,
            child: BarChart(
              BarChartData(
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: 12,
                  verticalInterval: 1, // Ne peut pas être 0
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey[300]!,
                    strokeWidth: 1,
                  ),
                  checkToShowVerticalLine: (value) =>
                      false, // Désactive les verticales
                ),
                alignment: BarChartAlignment.spaceAround,
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 10,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            '${value.toInt()}K',
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.grey[600],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const months = [
                          'Jan',
                          'Fév',
                          'Mar',
                          'Avr',
                          'Mai',
                          'Jun',
                          'Jul',
                          'Aug',
                          'Sep',
                          'Oct',
                          'Nov',
                          'Déc'
                        ];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            months[value.toInt()],
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.grey[600],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                barGroups: List.generate(12, (index) {
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: [
                          50,
                          40,
                          30,
                          20,
                          10,
                          25,
                          35,
                          45,
                          15,
                          5,
                          40,
                          20
                        ][index]
                            .toDouble(),
                        color: Color.fromARGB(255, 53, 39, 158),
                        width: 15,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
