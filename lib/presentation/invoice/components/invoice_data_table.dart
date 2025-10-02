import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/colors.dart';
import '../../../core/shared/dialogs/delete_dialog.dart';

class InvoiceDataTable extends StatelessWidget {
  final VoidCallback onItemPressed;

  const InvoiceDataTable({super.key, required this.onItemPressed});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 20.0,
      headingRowHeight: 55.0,
      dividerThickness: 0.3,
      decoration: BoxDecoration(
        color: HexColor("#E4E6E8").withOpacity(0.2),
      ),
      headingRowColor: MaterialStatePropertyAll(HexColor("#FBFBFB")),
      headingTextStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: HexColor("#081735")),
      columns: const [
        DataColumn(
          label: Expanded(
            child: Center(
              child: Text(
                'Payment ID',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(
              child: Text(
                'Parent',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(
              child: Text(
                'Status',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(
              child: Text(
                'Montant',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(
              child: Text(
                'P.Methode',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(
              child: Text(
                'Classe',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(
              child: Text(
                'Creation date',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(
              child: Text(
                'Action',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
      rows: List.generate(10, (index) => _buildDataRow(index, context)),
    );
  }

  DataRow _buildDataRow(int index, context) {
    return DataRow(
      onSelectChanged: (selected) {
        onItemPressed();
        if (selected == true) {
          print("Selected row index: $index");
        }
      },
      cells: [
        DataCell(
          Center(
            child: Text(
              "06c1774-7f3d",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: HexColor("#4B5563")),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              "Tommy Shelby",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: HexColor("#2E263DB2").withOpacity(0.7)),
            ),
          ),
        ),
        DataCell(
            buildStatusWidget(Random().nextInt(3))
        ),
        DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(
              '500 DT',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: HexColor("#4B5563"),
              ),
            ),
          ),
        ),
        DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(
              'Virement',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: HexColor("#4B5563"),
              ),
            ),
          ),
        ),
        DataCell(
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 25,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: HexColor("#FB7D5B"),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'VIA',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
        DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(
              'Mars 25, 2025',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: HexColor("#A098AE"),
              ),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  color: Colors.red,
                  onPressed: () {
                    showDeleteDialog(context, "Supprimer facture", () {});
                  },
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Iconsax.eye, color: HexColor("#303972B2")),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_outlined, color: Colors.green),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildStatusWidget(int index){
  List<Color> colors = [
    HexColor("#165E3D"),
    HexColor("#B5850B"),
    HexColor("#B83131"),
  ];
  List<IconData> icons = [
    Icons.done_outline,
    Icons.access_time,
    Icons.do_disturb_on_outlined,
  ];
  List<String> titles = [
    "Payée",
    "En attente",
    "Remboursé"
  ];
  return Container(
    decoration: BoxDecoration(
      color: colors[index].withOpacity(0.1),
      borderRadius: BorderRadius.circular(20)
    ),
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icons[index],color: colors[index],size: 15,),
        const SizedBox(width: 10,),
        Text(titles[index], style: TextStyle(color: colors[index]),)
      ],
    ),
  );
}
