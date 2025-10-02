import 'package:flutter/material.dart';

class ExpensesHeaderRev extends StatelessWidget {
  final VoidCallback onAddPressed;

  const ExpensesHeaderRev({super.key, required this.onAddPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Aperçu les Revenues",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon:
                    const Icon(Icons.cloud_download, color: Colors.black87, size: 18),
                label:
                    const Text("Exporter", style: TextStyle(color: Colors.black87)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(width: 12), // Espace entre les boutons
              ElevatedButton.icon(
                onPressed: onAddPressed,
                icon: const Icon(Icons.add, color: Colors.white, size: 18),
                label: const Text("Ajouter Revenue"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF70C4CF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
