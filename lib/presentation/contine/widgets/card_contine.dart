import 'package:flutter/material.dart';

class MealCard extends StatelessWidget {
  const MealCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 361,
      height: 588,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF4CB6AC), width: 2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            const Text(
              'Menu de jour',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              '05 Feb 2023',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Color(0xFF6B7387),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(height: 1, color: Color(0xFFE0E0E0)),
            const SizedBox(height: 20),

            // Morning snack section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 81,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF4CB6AC)),
                    borderRadius: BorderRadius.circular(42.25),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/morning_snack.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Collation Matin',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Jus orange + Gâteau',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Color(0xFF6B7387),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '10:30 AM',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(height: 1, color: Color(0xFFE0E0E0)),
            const SizedBox(height: 20),

            // Meal section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 82,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF4CB6AC)),
                    borderRadius: BorderRadius.circular(416.75),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/meal.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Repas',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      width: 200,
                      child: Text(
                        'Spaghetti Bolognaise + Salade + Pomme',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: Color(0xFF6B7387),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '12:00 PM',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(height: 1, color: Color(0xFFE0E0E0)),
            const SizedBox(height: 20),

            // Afternoon snack section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 82,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF4CB6AC)),
                    borderRadius: BorderRadius.circular(416.75),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/afternoon_snack.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Collation après-midi',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Cookies au chocolat',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Color(0xFF6B7387),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '3:30 PM',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // const Spacer(),
            const SizedBox(height: 20),
            const Divider(height: 1, color: Color(0xFFE0E0E0)),
            const SizedBox(height: 20),
            // Footer section
            Row(
              children: [
                const Text(
                  '15 Enfants',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Color(0xFF6B7387),
                  ),
                ),
                const Spacer(),
                // Delete Button
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 228, 31, 31)
                          .withOpacity(0.7),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Color.fromARGB(255, 228, 31, 31),
                  ),
                ),
                const SizedBox(width: 20),
                // Edit Button
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 30, 186, 98)
                          .withOpacity(0.7),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Color.fromARGB(255, 30, 186, 98),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
