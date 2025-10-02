import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class AbsencePieChart extends StatefulWidget {
  final double value;
  const AbsencePieChart({super.key, required this.value});

  @override
  State<AbsencePieChart> createState() => _AbsencePieChartState();
}

class _AbsencePieChartState extends State<AbsencePieChart> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white.withOpacity(0.9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
              sectionsSpace: 0,
              centerSpaceRadius: 50,
              sections: showingSections(),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  overflow: TextOverflow.ellipsis,
                  "${widget.value.toInt()}%", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25, color: HexColor("#0E132F")),),
                Text(
                  textAlign: TextAlign.center,
                  "Taux d’absentiésme" , style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: HexColor("#3E4259")),),
              ],
            ),
          )
        ],
      ),
    );
  }

  Color getColor(){
    if( widget.value >= 30){
      return HexColor("#EF7979");
    }
    else{
      return HexColor("#FDDC8B");
    }
  }
  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      const isTouched = false;
      const fontSize = isTouched ? 25.0 : 12.0;
      const radius = isTouched ? 50.0 : 25.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: getColor(),
            value: widget.value,
            title: isTouched ? '30% absence' : '',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: HexColor("#E1DFE4"),
            value: 100 - widget.value,
            title: isTouched ? '40%' : '',
            radius: radius,
            titleStyle: const TextStyle(
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
