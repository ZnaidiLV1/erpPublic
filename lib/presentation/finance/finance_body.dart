import 'package:biboo_pro/presentation/finance/widgets/bar_chart_widget.dart';
import 'package:flutter/material.dart';
import '../../core/components/summary_section_5.dart';
import '../../core/constants/di/getIt.dart';
import '../../core/services/expense_service.dart';
import '../../core/services/revenue_service.dart';
import '../../domain/models/expense/expense_model.dart';
import '../../domain/models/revenue/revenue_model.dart';

class FinanceBody extends StatelessWidget {
  final VoidCallback onDepencePressed;
  final VoidCallback onRevenuePressed;

  const FinanceBody({super.key, required this.onDepencePressed, required this.onRevenuePressed});

  double _getTotalExpense() {
    final List<ExpenseModel> expenses = getIt<ExpenseService>().getAllExpenses().map((e) => ExpenseModel.fromJson(e)).toList();
    return expenses.fold(0.0, (total, expense) {
      final amount = double.tryParse(expense.ammount ?? '0');
      return total + (amount ?? 0);
    });
  }
  double _getTotalRevenue() {
    final List<RevenueModel> revenues = getIt<RevenueService>().getAllRevenues().map((e) => RevenueModel.fromJson(e)).toList();
    return revenues.fold(0.0, (total, expense) {
      final amount = double.tryParse(expense.ammount ?? '0');
      return total + (amount ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SummarySection5(),
              // Financial Summary Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildFinanceCard(
                    icon: Icons.attach_money,
                    title: 'Solde total',
                    amount: '${_getTotalRevenue()} DT',
                    percentageChange: '+1.29%',
                    color: Colors.amber,
                  ),
                  InkWell(
                    onTap: onRevenuePressed,
                    child: buildFinanceCard(
                      icon: Icons.monetization_on,
                      title: 'Revenue total',
                      amount: '${_getTotalRevenue()} DT',
                      percentageChange: '+1.29%',
                      color: Colors.blue,
                    ),
                  ),
                  buildFinanceCard(
                    icon: Icons.account_balance_wallet,
                    title: 'Net totale',
                    amount: '${_getTotalRevenue() - _getTotalExpense()} DT',
                    percentageChange: '+1.29%',
                    color: Colors.green,
                  ),
                  InkWell(
                    onTap: onDepencePressed,
                    child: buildFinanceCard(
                      icon: Icons.money_off,
                      title: 'Dépenses totales',
                      amount: '${_getTotalExpense()} DT',
                      percentageChange: '+1.29%',
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Analytics Chart
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Color(0xFFD7D6F7)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Analytique',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF282458),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Revenue',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              'Dépenses',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.cyan,
                              ),
                            ),
                          ],
                        ),
                        DropdownButton<String>(
                          items: <String>['2024', '2023', '2022']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {},
                          hint: Text('2024'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Bar Chart
                    BarChartWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFinanceCard({
    required IconData icon,
    required String title,
    required String amount,
    required String percentageChange,
    required Color color,
  }) {
    return Container(
      width: 246,
      height: 164,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Color(0xFFD7D6F7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.19),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          Spacer(),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF8C89B4),
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF282458),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: percentageChange.startsWith('+')
                  ? Colors.green.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              percentageChange,
              style: TextStyle(
                fontSize: 12,
                color: percentageChange.startsWith('+')
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


