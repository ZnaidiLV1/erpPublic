import 'package:flutter/material.dart';
import '../../../core/constants/di/getIt.dart';
import '../../../core/services/expense_service.dart';
import '../../../core/shared/dialogs/delete_dialog.dart';
import '../../../domain/models/expense/expense_model.dart';
import 'modifier_depance.dart';

class ExpensesTable extends StatefulWidget {

  ExpensesTable({
    super.key,
  });

  @override
  State<ExpensesTable> createState() => _ExpensesTableState();
}

class _ExpensesTableState extends State<ExpensesTable> {
  final List<ExpenseModel> expenses = getIt<ExpenseService>().getAllExpenses().map((e) => ExpenseModel.fromJson(e)).toList();

  _updateData(){
    setState(() {
      expenses.clear();
      expenses.addAll(getIt<ExpenseService>().getAllExpenses().map((e) => ExpenseModel.fromJson(e)));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1212.2,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE4E6E8),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          _buildTableHeader(),
          // Rows
          ...expenses
              .map((expense) => _buildTableRow(expense, context))
              .toList(),
          SizedBox(height: 50,),
          // If no data, show empty state
          if (expenses.isEmpty) _buildEmptyState(),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      width: double.infinity,
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFFBFBFB),
        border: Border(top: BorderSide(color: Color(0xFFE4E6E8))),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE4E6E8),
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(value: false, onChanged: (value) {}),
          _buildHeaderItem("ID", flex: 1),
          _buildHeaderItem("Sous-catégorie", flex: 2),
          _buildHeaderItem("Catégories DEPENSES", flex: 2),
          _buildHeaderItem("Détails", flex: 2),
          _buildHeaderItem("Date", flex: 1),
          _buildHeaderItem("Montant", flex: 1),
          _buildHeaderItem("Action", flex: 1),
        ],
      ),
    );
  }

  Widget _buildHeaderItem(String title, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
            ),
          ),
          const Icon(Icons.expand_more, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildTableRow(ExpenseModel expense, BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE4E6E8), width: 1),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Checkbox(value: false, onChanged: (val) {}),
          _buildRowItem(expense.id.toString() ?? '', flex: 1),
          _buildRowItem(expense.subCategory ?? '', flex: 2),
          _buildRowItem(expense.category ?? '', flex: 2),
          _buildRowItem(expense.details ?? '', flex: 2),
          _buildRowItem(expense.date ?? '', flex: 1),
          _buildRowItem(expense.ammount ?? '', flex: 1),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _iconButton(
                  Icons.edit,
                  Colors.green,
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: "Ajouter classe",
                      transitionDuration: const Duration(milliseconds: 300),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Material(
                            color: Colors.white,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin:
                                    const Offset(1, 0), // Start from the right
                                end: Offset.zero, // End at its normal position
                              ).animate(CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              )),
                              child:  DepenseSettingsPanel(
                                onSave: (){
                                  _updateData();
                                  Navigator.of(context).pop();
                                },
                                onCancel: (){
                                  Navigator.of(context).pop();
                                },
                                expense: expense,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                _iconButton(onTap: () {
                  showDeleteDialog(context, "Supprimer dépense", () {
                    getIt<ExpenseService>().deleteExpense(expense.id!);
                    _updateData();
                  });
                }, Icons.delete, Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowItem(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xFF4B5563),
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _iconButton(IconData icon, Color color, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const SizedBox(
      height: 100,
      child: Center(
        child: Text(
          "Aucune dépense trouvée",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
