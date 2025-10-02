import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/components/summary_section.dart';
import '../../../core/constants/colors.dart';

import '../../../core/shared/entities/summaryItem.dart';
import 'all_invoices.dart';


class InvoiceBody extends StatelessWidget {
  final VoidCallback onAddPressed;
  final VoidCallback onItemPressed;

  const InvoiceBody({super.key, required this.onAddPressed, required this.onItemPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummarySection(
          items: [
            SummaryItem(
                label: 'Enfants',
                value: 150,
                icon: Iconsax.people,
                color: HexColor("#70C4CF")),
            SummaryItem(
                label: 'Facture',
                value: 50,
                icon: Iconsax.ticket,
                color: HexColor("#FB7D5B")),
            SummaryItem(
                label: 'Payée',
                value: 10,
                icon: Iconsax.wallet,
                color: HexColor("#56CA00")),
            SummaryItem(
                label: 'Impayée',
                value: 50,
                icon: Iconsax.money,
                color: HexColor("#E41F1F")),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Aperçu des paiements",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                  color: HexColor("#374151")),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(
                      Colors.white,
                    ),
                    fixedSize: const MaterialStatePropertyAll(Size(120, 36)),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: BorderSide(color: HexColor("#F0F2F4"), width: 1),
                      ),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Iconsax.document_download,
                        color: Colors.black,
                        size: 15,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Exporter",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: onAddPressed,
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      HexColor("#70C4CF"),
                    ),
                    fixedSize: const MaterialStatePropertyAll(Size(160, 36)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    )),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15,
                      ),
                      SizedBox(width: 5),
                      Text("Ajouter Facture", style: TextStyle(color: Colors.white, fontSize: 13),),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Row(
                  children: [
                    TabBar(
                      tabs: const [
                        Tab(text: 'Tous les paiements'),
                        Tab(text: "Payée"),
                        Tab(text: "En attente"),
                      ],
                      labelColor: HexColor("#70C4CF"),
                      unselectedLabelColor: bGris10,
                      indicatorColor: HexColor("#70C4CF"),
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                    ),
                    const Spacer()
                  ],
                ),
                const Divider(),
                 Expanded(
                  child: TabBarView(
                    children: [
                      Center(
                        child: AllInvoices(onItemPressed: onItemPressed),
                      ),
                      const Center(child: Text("2")),
                      const Center(child: Text("3")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
