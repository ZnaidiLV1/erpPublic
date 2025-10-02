import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class AbsenceChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.54,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Absence",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: HexColor("#EF7979"),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Absence",
                    style: TextStyle(
                        fontSize: 10,
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
        const SizedBox(
          height: 35,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.54,
          height: 290,
          // Set height
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Colors.white, // Background color
          ),
          child: LineChart(
            LineChartData(
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)), // Hide top
                rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)), // Hide right
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) => Text(
                      (value < 300) ? "${value.toInt()}%" : "",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none, // Remove underline
                      ),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 25,
                    getTitlesWidget: (value, meta) {
                      const months = [
                        'Jan',
                        'Feb',
                        'Mar',
                        'Apr',
                        'May',
                        'Jun',
                        'Jul',
                        'Aug',
                        'Sep',
                        'Oct',
                        'Nov',
                        'Dec'
                      ];
                      return Text(
                        months[value.toInt()],
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none, // Remove underline
                        ),
                      );
                    },
                    interval: 1,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: false,
                border: const Border(
                  left: BorderSide(color: Colors.black, width: 1),
                  bottom: BorderSide(color: Colors.black, width: 1),
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false, // Hide vertical grid lines
                horizontalInterval: 10, // Spacing for horizontal lines
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey.shade300, // Light grey grid
                  strokeWidth: 1,
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    const FlSpot(0, 0),
                    const FlSpot(1, 5),
                    const FlSpot(2, 5),
                    const FlSpot(3, 10),
                    const FlSpot(4, 10),
                    const FlSpot(5, 20),
                    const FlSpot(6, 20),
                    const FlSpot(7, 15),
                    const FlSpot(8, 20),
                    const FlSpot(9, 20),
                    const FlSpot(10, 25),
                    const FlSpot(11, 20),
                  ],
                  isCurved: true,
                  color: HexColor("#EF7979"),
                  // gradient: LinearGradient(
                  //   colors: [HexColor("#FCC43E"), HexColor("#FCC43E")],
                  // ),
                  barWidth: 5,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [HexColor("#EF7979").withOpacity(0.2), HexColor("#EF7979").withOpacity(0.01)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  dotData: const FlDotData(show: false),
                ),
              ],
              minX: 0,
              maxX: 11,
              minY: 0,
            ),
          ),
        ),
      ],
    );
  }
}
