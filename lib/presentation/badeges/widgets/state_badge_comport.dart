import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1093.71,
      height: 147.84,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStatCard(
            icon: Icons.shield,
            iconColor: Colors.amber,
            iconBackgroundColor: const Color(0xFFFFF8E1),
            number: "4",
            label: "Catégories\ndes badges",
          ),
          SizedBox(width: 20),
          _buildStatCard(
            icon: Icons.person,
            iconColor: Colors.blue,
            iconBackgroundColor: const Color(0xFFE3F2FD),
            number: "80",
            label: "Enfants",
          ),
          SizedBox(width: 20),
          _buildStatCard(
            icon: Icons.emoji_events,
            iconColor: Colors.green,
            iconBackgroundColor: const Color(0xFFE0F2F1),
            number: "40",
            label: "Les gagnants",
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBackgroundColor,
    required String number,
    required String label,
  }) {
    return Container(
      width: 331.24,
      height: 147.84,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFEEEEEE),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with shadow
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: iconColor.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 32,
              ),
            ),
          ),

          // Divider
          Container(
            height: 80,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: VerticalDivider(
              color: Colors.grey.withOpacity(0.2),
              thickness: 1,
              width: 1,
            ),
          ),
          const SizedBox(width: 20),
          // Text content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                number,
                style: const TextStyle(
                  color: Color(0xFF2E3A59),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
