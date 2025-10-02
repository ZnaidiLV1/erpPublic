import 'package:flutter/material.dart';

import '../../../core/constants/di/getIt.dart';
import '../../../core/services/expense_service.dart';
import '../../../core/services/revenue_service.dart';
import '../../../domain/models/expense/expense_model.dart';
import '../../../domain/models/revenue/revenue_model.dart';


class BarChartWidget extends StatelessWidget {

  List<double> _getRevenueHeights(){
     List<double> _revenueheights = List.filled(12, 0);
    final List<RevenueModel> revenues =
    getIt<RevenueService>().getAllRevenues().map((e) => RevenueModel.fromJson(e)).toList();
    revenues.forEach((e) {
      if (e.date != null && e.ammount != null && e.date!.split('-')[2] == DateTime.now().year.toString()) {
        int monthIndex = int.tryParse(e.date!.split('-')[1]) ?? 0;
        double amount = double.tryParse(e.ammount!) ?? 0;
        _revenueheights[monthIndex - 1] += amount;
      }
    });
    return _revenueheights.map((e) => e / 20).toList();
  }
  List<double> _getExpenseHeights(){
    List<double> _expenseheights = List.filled(12, 0);
    final List<ExpenseModel> expenses =
    getIt<ExpenseService>().getAllExpenses().map((e) => ExpenseModel.fromJson(e)).toList();
    expenses.forEach((e) {

      if (e.date != null && e.ammount != null && e.date!.split('-')[2] == DateTime.now().year.toString()) {
        int monthIndex = int.tryParse(e.date!.split('-')[1]) ?? 0;
        double amount = double.tryParse(e.ammount!) ?? 0;
        _expenseheights[monthIndex - 1] += amount;
      }
    });
    return _expenseheights.map((e) => e / 20).toList();
  }
  @override
  Widget build(BuildContext context) {

    final List<double> revenueHeights = _getRevenueHeights();
    final List<double> expensesHeights = _getExpenseHeights();


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(12, (index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Barres côte à côte
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Barre de revenu
                Container(
                  width: 10,
                  height: revenueHeights[index],
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(width: 4), // Espace entre les barres
                // Barre de dépense
                Container(
                  width: 10,
                  height: expensesHeights[index],
                  decoration: const BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              [
                'Jan',
                'Febv',
                'Mar',
                'Apr',
                'Mai',
                'Jun',
                'Jul',
                'Aug',
                'Sep',
                'Oct',
                'Nov',
                'Dec'
              ][index],
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF8C89B4),
              ),
            ),
          ],
        );
      }),
    );
  }
}