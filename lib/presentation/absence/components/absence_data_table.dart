
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class AbsenceDataTable extends StatelessWidget {
  final VoidCallback onItemPressed;

  const AbsenceDataTable({super.key, required this.onItemPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: DataTable(
        columnSpacing: 20.0,
        headingRowHeight: 55.0,
        dividerThickness: 0.3,
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
                  'Ennfant',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Center(
                child: Text(
                  'Motif d’absence',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Center(
                child: Text(
                  'Date',
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
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
        rows: List.generate(10, (index) => _buildDataRow(index, context)),
      ),
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
        const DataCell(
          Row(
            children: [
              CircleAvatar(
                radius: 15,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Student Name',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(
              'Maladies',
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
              'Mars 25, 2025',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: HexColor("#A098AE"),
              ),
            ),
          ),
        ),
        DataCell(
            Center(child: buildStatusWidget())
        ),
      ],
    );
  }
}

Widget buildStatusWidget(){
  return Container(
    decoration: BoxDecoration(
        color: HexColor("##E41F1F").withOpacity(0.1),
        borderRadius: BorderRadius.circular(20)
    ),
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
    child: Text("Absent", style: TextStyle(color: HexColor("##E41F1F"),fontSize: 15,fontWeight: FontWeight.w500),),
  );
}
