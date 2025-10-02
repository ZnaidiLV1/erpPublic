import 'package:flutter/material.dart';

class HistoriqueGagnantWidget extends StatelessWidget {
  final VoidCallback onItemPressed;

  const HistoriqueGagnantWidget({super.key, required this.onItemPressed});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade600,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Gagnant historique',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: onItemPressed,
                  child: const Text(
                    'Voir tout',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildWinnerTile(
                        'Nesrine Dziri',
                        'Avr 27, 2024',
                        'Comportement',
                        'assets/nesrine.png', // Chemin vers l'image
                      ),
                      _buildWinnerTile(
                        'Mohamed Mbarek',
                        'Avr 25, 2024',
                        'Participation',
                        'assets/mohamed.png', // Chemin vers l'image
                      ),
                      _buildWinnerTile(
                        'Jihed Kacem',
                        'Avr 1, 2024',
                        'Performance Sportive',
                        'assets/jihed.png', // Chemin vers l'image
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWinnerTile(
      String name, String date, String category, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            category,
            style: TextStyle(
              fontSize: 14,
              color: _getCategoryColor(category),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Comportement':
        return Colors.blue;
      case 'Participation':
        return Colors.cyan;
      case 'Performance Sportive':
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}
