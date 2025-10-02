import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30,),
         Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Efants", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
            Text("La répartition des enfants est composée de filles et de garçons",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: HexColor("#8F95B2")),),
            const SizedBox(height: 10,),
            const SizedBox(
              width: 380,
              child: Divider(thickness: 1.5,),
            )
          ],
        ),
        const SizedBox(height: 10,),
        Container(
          height: 180,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.white.withOpacity(0.9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 15,
                offset: const Offset(0, 1),
              ),
            ],
          ),

          child: Stack(
            children: [
              PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex =
                            pieTouchResponse.touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: true),
                  sectionsSpace: 2,
                  centerSpaceRadius: 50,
                  sections: showingSections(),
                ),
              ),
              Center(
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 4,
                        blurRadius: 15,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        overflow: TextOverflow.ellipsis,
                        "84", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: HexColor("#0049C6")),),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        "Total" , style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: HexColor("#0049C6")),),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 40,),
        Row(
          children: [
            const SizedBox(width: 150,),
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
              "Garçon",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: HexColor("#808191")),
            ),
            const SizedBox(
              width: 30,
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
              "Fille",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: HexColor("#808191")),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        )
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 12.0;
      final radius = isTouched ? 50.0 : 25.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: HexColor("#3D5EE1"),
            value: 60,
            title: isTouched ? '60%' : '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: HexColor("#70C4CF"),
            value: 40,
            title: isTouched ? '40%' : '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );

        default:
          throw Error();
      }
    });
  }
}
