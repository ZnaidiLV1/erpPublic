import 'package:biboo_pro/core/components/today_widget.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../shared/entities/summaryItem.dart';

class SummarySection2 extends StatefulWidget {
  final List<SummaryItem> items;

  const SummarySection2({super.key, required this.items});

  @override
  State<SummarySection2> createState() => _SummarySection2State();
}

class _SummarySection2State extends State<SummarySection2> {
  List<Widget> itemList = [const TodayWidget(), const SizedBox()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemList.addAll(widget.items.map((item) => itemCard(item)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: itemList,
    );
  }

  Widget itemCard(final SummaryItem item) {
    return Container(
      height: 90,
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: HexColor("#F8F8F8"),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            item.value.toString(),
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: HexColor("#252C58")),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            overflow: TextOverflow.ellipsis,
            item.label,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: HexColor("#252C58")),
          ),
          const Spacer(),
          CircleAvatar(
            radius: 20,
            backgroundColor: HexColor("#E6EAF5"),
            child: Icon(item.icon, size: 18, color: HexColor("#081735")),
          ),
        ],
      ),
    );
  }
}
