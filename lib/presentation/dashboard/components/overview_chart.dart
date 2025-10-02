import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class OverViewChart extends StatelessWidget {
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
                "Overview",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: HexColor("#3D5EE1"),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Animatrice",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: HexColor("#808191")),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: HexColor("#70C4CF"),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Enfants",
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
        const SizedBox(height: 5,),
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
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) => Text(
                      value.toInt().toString(),
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
                    const FlSpot(0, 10),
                    const FlSpot(1, 20),
                    const FlSpot(2, 30),
                    const FlSpot(3, 40),
                    const FlSpot(4, 35),
                    const FlSpot(5, 25),
                    const FlSpot(6, 20),
                    const FlSpot(7, 15),
                    const FlSpot(8, 30),
                    const FlSpot(9, 40),
                    const FlSpot(10, 30),
                    const FlSpot(11, 20),
                  ],
                  isCurved: true,
                  color: HexColor("#3D5EE1"),
                  barWidth: 5,
                  dotData: const FlDotData(show: false),
                ),
                LineChartBarData(
                  spots: [
                    const FlSpot(0, 5),
                    const FlSpot(1, 15),
                    const FlSpot(2, 25),
                    const FlSpot(3, 20),
                    const FlSpot(4, 30),
                    const FlSpot(5, 20),
                    const FlSpot(6, 20),
                    const FlSpot(7, 50),
                    const FlSpot(8, 45),
                    const FlSpot(9, 35),
                    const FlSpot(10, 15),
                    const FlSpot(11, 10),
                  ],
                  isCurved: true,
                  color: HexColor("#70C4CF"),
                  barWidth: 5,
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
