import 'package:biboo_pro/presentation/finance/revenues/add_revenue.dart';
import 'package:biboo_pro/presentation/finance/revenues/listrevenue.dart';
import 'package:flutter/material.dart';
import 'expenses/add_depance.dart';
import 'expenses/listdepance.dart';
import 'finance_body.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  int index = 0;

  void _changeScreen(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: [
      FinanceBody(
          onDepencePressed: () => _changeScreen(1),
        onRevenuePressed: () => _changeScreen(3),
        ),
         ListDepance(
          onAddPressed: () => _changeScreen(2),
           onCancelPressed: () => _changeScreen(0),
        ),
        AddDepense(onCancelPressed: () => _changeScreen(1),),
        ListRevenue(
            onAddPressed: () => _changeScreen(4),
            onCancelPressed: () => _changeScreen(0)),
        AddRevenue(onCancelPressed: () => _changeScreen(3),)
      ],
    );
  }
}

