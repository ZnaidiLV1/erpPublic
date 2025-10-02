
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constants/colors.dart';
import 'invoice_data_table.dart';

class AllInvoices extends StatelessWidget {
  final VoidCallback onItemPressed;

  const AllInvoices({super.key, required this.onItemPressed});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 10,),
        Row(
          children: [
            Container(
              width: 120,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(Icons.date_range,
                      size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: const SizedBox(),
                      hint: const Text('Date',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              fontFamily: 'Poppins')),
                      items: ['Date 1', 'Date 2', 'Date 3']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5,),
            Container(
              width: 120,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(Icons.attach_money,
                      size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: const SizedBox(),
                      hint: const Text('P. Methode',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              fontFamily: 'Poppins')),
                      items: ['P. Methode 1', 'P. Methode 2', 'P. Methode 3']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 45,
              width: 400,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Rechercher par montant, méthode de paiement...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                  ),
                  prefixIcon: Icon(
                    Iconsax.search_normal,
                    color: HexColor("#959BA4"),
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20,),
        InvoiceDataTable(onItemPressed: onItemPressed),
      ],
    );
  }
}
