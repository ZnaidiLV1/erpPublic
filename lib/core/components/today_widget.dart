import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../constants/colors.dart';

class TodayWidget extends StatefulWidget {
  const TodayWidget({super.key});

  @override
  State<TodayWidget> createState() => _TodayWidgetState();
}

class _TodayWidgetState extends State<TodayWidget> {
  late String _currentTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateFormat("hh:mm a").format(DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 545,
      height: 180,
      child: Stack(
        children: [
          Positioned(
            top: 45,
            child: Container(
              width: 545,
              height: 88,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [HexColor("#F9F8F6"), HexColor("#70C4CF")],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat("d MMMM yyyy").format(DateTime.now()),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: HexColor("#424242")),
                      ),
                      Text(
                        "Aujourd'hui",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 32,
                            color: HexColor("#424242")),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 25,
                    width: 125,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: HexColor("#73877B")),
                    child: Text(
                      "Présent-à-l'heure",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: HexColor("#EEEEEE")),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Heure",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: HexColor("#D9F0C5")),
                      ),
                      Text(
                        _currentTime,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 32,
                            color: HexColor("#D9F0C5")),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 170,
            child: Image.asset("assets/images/work_man.png"),
          ),
        ],
      ),
    );
  }
}
