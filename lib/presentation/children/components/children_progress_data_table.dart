import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class ChildrenProgressDataTable extends StatelessWidget {
  const ChildrenProgressDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DataTable(
        columnSpacing: 20.0,
        headingRowHeight: 55.0,
        dividerThickness: 0.3,
        headingRowColor: MaterialStatePropertyAll(HexColor("#F1F9FA")),
        headingTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: HexColor("#70C4CF")),
        columns: const [
          DataColumn(
            label: Expanded(
              child: Text(
                'Nom Et Prénom',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Center(
                child: Text(
                  'Date et heure',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Center(
                child: Text(
                  'Pourcentage',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Center(
                child: Text(
                  'Nom d’animatrice',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
        rows: List.generate(10, (index) => _buildDataRow(index)),
      ),
    );
  }

  DataRow _buildDataRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          SizedBox(
            width: 150,
            child: Row(
              children: [
                 CircleAvatar(
                  radius: 15,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/avatar_1.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Student Name',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: HexColor("#303972"),
                    ),
                  ),
                ),
              ],
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
          Align(
            alignment: Alignment.center,
            child: Text(
              '60%',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: HexColor("#303972"),
              ),
            ),
          ),
        ),
        DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(
              'Marwa Jbarra',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: HexColor("#303972"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
