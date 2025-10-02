import 'package:biboo_pro/presentation/finance/revenues/rev_report_head.dart';
import 'package:biboo_pro/presentation/finance/revenues/table_revenue.dart';
import 'package:flutter/material.dart';

import '../../../core/components/summary_section_5.dart';
import 'filter_bar_revenue.dart';

class ListRevenue extends StatefulWidget {
  final VoidCallback onAddPressed;
  final VoidCallback onCancelPressed;
  const ListRevenue({super.key, required this.onAddPressed, required this.onCancelPressed});

  @override
  State<ListRevenue> createState() => _ListRevenueState();
}

class _ListRevenueState extends State<ListRevenue>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Sample data for demonstration
  final List<Map<String, dynamic>> _revenues = [
    {
      'id': '001',
      'subcategory': 'Vente',
      'category': 'Revenus de vente',
      'details': 'Paiement mensuel',
      'date': 'Mar 23, 2022, 13:00 PM',
      'amount': '500 DT',
    },
    {
      'id': '002',
      'subcategory': 'Service',
      'category': 'Revenus de service',
      'details': 'Paiement mensuel',
      'date': 'Mar 23, 2022, 13:00 PM',
      'amount': '300 DT',
    },
    {
      'id': '003',
      'subcategory': 'Location',
      'category': 'Revenus de location',
      'details': 'Paiement mensuel',
      'date': 'Mar 23, 2022, 13:00 PM',
      'amount': '700 DT',
    },
    // Add more revenues as needed
  ];

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
            ExpensesHeaderRev(onAddPressed: widget.onAddPressed,),
            const SizedBox(height: 20),
            ExpensesFilterBarRev(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RevenueTable(),
            ),
          ],
        ),
      ),
    );
  }
}
