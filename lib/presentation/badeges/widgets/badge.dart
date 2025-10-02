import 'package:flutter/material.dart';

class Badges extends StatefulWidget {
  const Badges({super.key});

  @override
  State<Badges> createState() => _BadgesState();
}

class _BadgesState extends State<Badges> {
  String dropdownValue = 'Juin – Juillet';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 550,
        height: 400,
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
        child: BadgeWidget(
          dropdownValue: dropdownValue,
          onDropdownChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
        ),
      ),
    );
  }
}

class BadgeWidget extends StatelessWidget {
  final String dropdownValue;
  final ValueChanged<String?> onDropdownChanged;

  const BadgeWidget({
    super.key,
    required this.dropdownValue,
    required this.onDropdownChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Meilleur Gagnant',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                onChanged: onDropdownChanged,
                items: <String>['Juin – Juillet', 'Mai – Juin', 'Avril – Mai']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Exemple d'utilisation avec des badges
                  _buildWinnerCard(
                    color: Colors.blue[900]!,
                    name: "Mohamed Mbarek",
                    classe: "Classe XVJ",
                    percentage: "90%",
                    date: "22-01-2025",
                    category: "Comportement",
                    image: CircleAvatar(
                      backgroundImage: AssetImage('assets/profile.jpg'),
                      radius: 30,
                    ),
                    badges: [
                      Image.asset('assets/images/badge_1.png',
                          width: 40, height: 40),
                    ],
                  ),
                  const SizedBox(width: 15),
                  _buildWinnerCard(
                    color: Colors.cyan[300]!,
                    name: 'Mohamed Dineri',
                    classe: 'Classe XIA',
                    percentage: '80%',
                    date: '22-01-2025',
                    category: 'Participation',
                    image: const CircleAvatar(
                      backgroundImage: AssetImage('assets/user2.png'),
                    ),
                    badges: [
                      Image.asset('assets/images/badge_2.png',
                          width: 40, height: 40),
                    ],
                  ),
                  const SizedBox(width: 15),
                  _buildWinnerCard(
                    color: Colors.pink[300]!,
                    name: 'Jihed Kacem',
                    classe: 'Classe XIV',
                    percentage: '70%',
                    date: '22-01-2025',
                    category: 'Compétence en lecture',
                    image: const CircleAvatar(
                      backgroundImage: AssetImage('assets/user3.png'),
                    ),
                    badges: [
                      Image.asset('assets/images/badge_3.png',
                          width: 40, height: 40),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWinnerCard({
    required Color color,
    required String name,
    required String classe,
    required String percentage,
    required String date,
    required String category,
    required CircleAvatar image,
    List<Widget> badges = const [], // Nouveau paramètre pour les badges
  }) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Contenu principal de la carte
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                image,
                const SizedBox(height: 10),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  classe,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  percentage,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    category,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Positionnement des badges
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var badge in badges)
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: badge,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
