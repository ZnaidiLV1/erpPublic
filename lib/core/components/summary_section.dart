import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../shared/entities/summaryItem.dart';

class SummarySection extends StatelessWidget {
  final List<SummaryItem> items;

  const SummarySection({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: HexColor("#E6EBEE"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                items.map((item) => _SummaryCardItem(item: item)).toList(),
          ),
        ),
      ),
    );
  }
}

class _SummaryCardItem extends StatelessWidget {
  final SummaryItem item;

  const _SummaryCardItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor:
                  item.color, // Couleur spécifique pour chaque icône
              child: Icon(item.icon, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10), // Espacement entre l'icône et le texte
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.label,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 15.4,
                    height: 16 / 15.4,
                    color: Color.fromRGBO(160, 152, 174, 1),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item.value.toString(),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    height: 24 / 24,
                    color: Color.fromRGBO(8, 23, 53, 1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}


