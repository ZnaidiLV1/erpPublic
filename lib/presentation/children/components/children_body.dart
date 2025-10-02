import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/components/summary_section_2.dart';
import '../../../core/constants/colors.dart';
import '../../../core/shared/entities/summaryItem.dart';
import 'children_data_table.dart';

class ChildrenBody extends StatelessWidget {
  final VoidCallback onAddPressed;
  final VoidCallback onItemPressed;

  const ChildrenBody({super.key, required this.onAddPressed, required this.onItemPressed});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SummarySection2(
          items: [
            SummaryItem(
              label: 'Enfants',
              value: 150,
              icon: Iconsax.people,
              color: HexColor("#70C4CF"),
            ),
            SummaryItem(
              label: 'Animatrice',
              value: 25,
              icon: Iconsax.task_square,
              color: HexColor("#FB7D5B"),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50,
              width: 200,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Search here...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                  ),
                  prefixIcon: Icon(
                    Iconsax.search_normal,
                    color: HexColor("#4D44B5"),
                    size: 18,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: onAddPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  HexColor("#70C4CF"),
                ),
                fixedSize: const MaterialStatePropertyAll(Size(160, 50)),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(width: 5),
                  Text("Ajouter enfant",style: TextStyle(color: Colors.white, fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
         ChildrenDataTable(onItemPressed: onItemPressed),
      ],
    );
  }
}

