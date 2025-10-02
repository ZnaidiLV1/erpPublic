import 'package:flutter/material.dart';

import '../../../core/constants/di/getIt.dart';
import '../../../core/services/revenue_service.dart';
import '../../../core/shared/dialogs/delete_dialog.dart';
import '../../../domain/models/revenue/revenue_model.dart';
import 'modif_revenu.dart';

class RevenueTable extends StatefulWidget {
   const RevenueTable({
    super.key,
  });

  @override
  State<RevenueTable> createState() => _RevenueTableState();
}

class _RevenueTableState extends State<RevenueTable> {
  final List<RevenueModel> revenues =
  getIt<RevenueService>().getAllRevenues().map((e) => RevenueModel.fromJson(e)).toList();

  _updateData(){
    setState(() {
      revenues.clear();
      revenues.addAll(getIt<RevenueService>().getAllRevenues().map((e) => RevenueModel.fromJson(e)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1212.2,
      decoration: BoxDecoration(
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
          ...revenues
              .map((revenue) => _buildTableRow(revenue, context))
              .toList(),
          // If no data, show empty state
          if (revenues.isEmpty) _buildEmptyState(),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      width: double.infinity,
      height: 52,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
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
          _buildHeaderItem("Catégories REVENUS", flex: 2),
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
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
            ),
          ),
          Icon(Icons.expand_more, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildTableRow(RevenueModel revenue, BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE4E6E8), width: 1),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 20),
          Checkbox(value: false, onChanged: (val) {}),
          _buildRowItem(revenue.id.toString() ?? '', flex: 1),
          _buildRowItem(revenue.subCategory ?? '', flex: 2),
          _buildRowItem(revenue.category ?? '', flex: 2),
          _buildRowItem(revenue.details ?? '', flex: 2),
          _buildRowItem(revenue.date ?? '', flex: 1),
          _buildRowItem(revenue.ammount ?? '', flex: 1),
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
                      barrierLabel: "Modifier revenu",
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
                              child: RevenueSettingsPanel(
                                revenue: revenue,
                              onCancel: (){
                                  Navigator.of(context).pop();
                              },
                                onSave: (){
                                  _updateData();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                _iconButton(onTap: (){
                  showDeleteDialog(context, "Supprimer revenue", (){
                    getIt<RevenueService>().deleteRevenue(revenue.id!);
                    _updateData();
                  });

                },Icons.delete, Colors.red),
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
        style: TextStyle(
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
      child: GestureDetector(
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
          "Aucun revenu trouvé",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
