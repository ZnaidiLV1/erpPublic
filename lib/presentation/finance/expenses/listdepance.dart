import 'package:biboo_pro/presentation/finance/expenses/table_depance.dart';
import 'package:flutter/material.dart';

import '../../../core/components/summary_section_5.dart';
import 'exporthead.dart';
import 'filter_bar_depance.dart';

class ListDepance extends StatefulWidget {
  final VoidCallback onAddPressed;
  final VoidCallback onCancelPressed;
  const ListDepance({super.key, required this.onAddPressed, required this.onCancelPressed});

  @override
  State<ListDepance> createState() => _ListDepanceState();
}

class _ListDepanceState extends State<ListDepance>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: IconButton(onPressed: widget.onCancelPressed, icon: const Icon(Icons.close)),
                ),
              ],
            ),
            const SummarySection5(),
            const SizedBox(height: 20),
            ExpensesHeader(onAddPressed: widget.onAddPressed,),
            const SizedBox(height: 20),
            ExpensesFilterBar(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ExpensesTable(),
            ),
          ],
        ),
      ),
    );
  }
}
