import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class ReviewChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        children: [
          const SizedBox(height: 30,),
           SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Graphique des avis sur les chauffeurs",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24, color: HexColor("#303972")),
                ),
                Row(
                  children: [
                    Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: HexColor("#FCC43E"),
                          width: 5
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Avis",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: HexColor("#808191")),
                    ),


                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 35),
          Container(
            width: double.infinity,
            height: 400,
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(color: Colors.white),
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 11,
                minY: 0,
                maxY: 100, // Max Y is 100
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)), // Hide top axis
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)), // Hide right axis
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 20,
                      getTitlesWidget: (value, meta) {
                        if (value % 20 == 0) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 10, color: Colors.black),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 25,
                      getTitlesWidget: (value, meta) {
                        const months = [
                          'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                        ];
                        int currentMonth = DateTime.now().month - 1;
                        return Text(
                          months[value.toInt()],
                          style: TextStyle(
                            fontWeight: value.toInt() == currentMonth ? FontWeight.w700 : FontWeight.w600,
                            fontSize: 16,
                            color: value.toInt() == currentMonth ? Colors.black :HexColor("#A098AE"),
                          ),
                        );
                      },
                      interval: 1,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                  border: Border.all(color: Colors.transparent),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  drawHorizontalLine: false,
                  verticalInterval: 1,
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.grey.shade300,
                    strokeWidth: 1,
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 10), const FlSpot(1, 30), const FlSpot(2, 50), const FlSpot(3, 90),
                      const FlSpot(4, 70), const FlSpot(5, 60), const FlSpot(6, 60), const FlSpot(7, 40),
                      const FlSpot(8, 30), const FlSpot(9, 40), const FlSpot(10, 30), const FlSpot(11, 20),
                    ],
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [HexColor("#FCC43E"), HexColor("#FCC43E")],
                    ),
                    barWidth: 5,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [HexColor("#FCC43E").withOpacity(0.5), HexColor("#FCC43E").withOpacity(0.1)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
