import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constants/colors.dart';
import '../../../core/shared/dialogs/delete_dialog.dart';
import 'add_children.dart';

class ChildrenDataTable extends StatefulWidget {
  final VoidCallback onItemPressed;
  final String searchText;
  final String? governorate;
  final String? classCode;

  const ChildrenDataTable({super.key, required this.onItemPressed, this.searchText = '', this.governorate, this.classCode});

  @override
  State<ChildrenDataTable> createState() => _ChildrenDataTableState();
}

class _ChildrenDataTableState extends State<ChildrenDataTable> {
  final List<Map<String, dynamic>> _data = [
    {
      'id': 'ID 123456789', 'name': 'Samah Mili', 'birth': 'Mars 25, 2025', 'parent': 'Souhaila Lamri', 'gov': 'Sousse', 'class': 'PS', 'avatar': 'assets/images/avatar_1.png'
    },
    {
      'id': 'ID 987654321', 'name': 'Wajdi Lkhchini', 'birth': 'Mars 25, 2025', 'parent': 'Othmen Lkhchini', 'gov': 'Sfax', 'class': 'TPS', 'avatar': 'assets/images/avatar_1.png'
    },
    {
      'id': 'ID 111213141', 'name': 'Maram samii', 'birth': 'Mars 25, 2025', 'parent': 'Maryem Hope', 'gov': 'Sousse', 'class': 'MS', 'avatar': 'assets/images/avatar_1.png'
    },
    {
      'id': 'ID 555666777', 'name': 'Islem Lfathi', 'birth': 'Mars 25, 2025', 'parent': 'Noura Nasir', 'gov': 'Tunis', 'class': 'CE1', 'avatar': 'assets/images/avatar_1.png'
    },
    {
      'id': 'ID 555666777', 'name': 'Gofran Trabelsi', 'birth': 'Mars 25, 2025', 'parent': 'Aniss Trabelsi', 'gov': 'Tunis', 'class': 'CE1', 'avatar': 'assets/images/avatar_1.png'
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    return _data.where((row) {
      final matchesSearch = widget.searchText.isEmpty ||
          row['name'].toString().toLowerCase().contains(widget.searchText.toLowerCase()) ||
          row['parent'].toString().toLowerCase().contains(widget.searchText.toLowerCase()) ||
          row['id'].toString().toLowerCase().contains(widget.searchText.toLowerCase());
      final matchesGov = widget.governorate == null || widget.governorate!.isEmpty || row['gov'] == widget.governorate;
      final matchesClass = widget.classCode == null || widget.classCode!.isEmpty || row['class'] == widget.classCode;
      return matchesSearch && matchesGov && matchesClass;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 20.0,
      headingRowHeight: 55.0,
      dividerThickness: 0.3,
      showCheckboxColumn: false,
      headingRowColor: MaterialStatePropertyAll(HexColor("#FBFBFB")),
      headingTextStyle: TextStyle(fontWeight: FontWeight.w500,
          fontSize: 13, color: HexColor("#081735")),
      columns: const [
        DataColumn(label: Center(child: Text('Status'))),
        DataColumn(label: Center(child: Text('Nom Et Prénom'))),
        DataColumn(label: Center(child: Text('ID'))),
        DataColumn(label: Center(child: Text('Date De Naissance'))),
        DataColumn(label: Center(child: Text('Nom Du Parent'))),
        DataColumn(label: Center(child: Text('Gouvernorat'))),
        DataColumn(label: Center(child: Text(' Contact'))),
        DataColumn(label: Center(child: Text('Classe'))),
        DataColumn(label: Center(child: Text('Action'))),
      ],
      rows: _filtered.map((row) => _buildRow(context, row)).toList(),
    );
  }

  DataRow _buildRow(BuildContext context, Map<String, dynamic> row) {
    return DataRow(onSelectChanged: (selected)
    { if (selected == true) widget.onItemPressed(); }, cells: [
      const DataCell(Center(child: Icon(Icons.circle, color: Colors.green, size: 12))),
      DataCell(Row(children: [
        const CircleAvatar(radius: 14),
        const SizedBox(width: 8),
        Expanded(child: Text(row['name'], overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: HexColor("#303972"))))
      ])),
      DataCell(Center(child: Text(row['id'], overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: bSecondaryColor)))),
      DataCell(Center(child: Text(row['birth'], overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: HexColor("#A098AE"))))),
      DataCell(Center(child: Text(row['parent'], overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: HexColor("#303972"))))),
      DataCell(Center(child: Text(row['gov'], overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, color: HexColor("#303972"))))),
      const DataCell(Center(child: _ContactIcons())),
      DataCell(Center(child: Container(height: 25, width: 40, alignment: Alignment.center, decoration: BoxDecoration(color: HexColor("#FB7D5B"), borderRadius: BorderRadius.circular(8)), child: Text(row['class'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 10))))),
       DataCell(Center(child: _ActionsCell(
        onDelete: () {
          setState(() {
            _data.remove(row);
          });
        },
      ),)),
    ]);
  }
}

class _ContactIcons extends StatelessWidget {
  const _ContactIcons();
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      CircleAvatar(backgroundColor: HexColor("#EBEBF9"),radius: 13  ,child: Icon(Icons.call_outlined, color: HexColor("#70C4CF"), size: 14)),
      const SizedBox(width: 6),
      CircleAvatar(backgroundColor: HexColor("#EBEBF9"),radius: 13 , child: Icon(Icons.message_outlined, color: HexColor("#70C4CF"), size: 14)),
      const SizedBox(width: 6),
      CircleAvatar(backgroundColor: HexColor("#EBEBF9"), radius: 13 ,child: Icon(Icons.mail_outline_rounded, color: HexColor("#70C4CF"), size: 14)),
    ]);
  }
}

class _ActionsCell extends StatelessWidget {
  final VoidCallback onDelete;

  const _ActionsCell({required this.onDelete, super.key});
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      IconButton(color: Colors.red, onPressed: () {
        showDeleteDialog(context, "Supprimer cet enfant", () {
          // Delete action
          onDelete(); // call parent delete

          Navigator.pop(context);
        })
        ;
      }, icon: const Icon(Icons.delete_outline_rounded)),
      const SizedBox(width: 4),
      IconButton(onPressed: () {
        // Edit action
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  AddChildren(onCancelPressed: () {  }, isEdit: true),
          ),
        );


      },
          icon: const Icon(Icons.edit_outlined, color: Colors.green)),
    ]);
  }
}