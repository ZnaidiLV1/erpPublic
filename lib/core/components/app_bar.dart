import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DashboardHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const DashboardHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNineDotsIcon(), // Icône avec 9 points avant le texte
          const SizedBox(width: 10), // Espacement entre l'icône et le texte
          Text(
            title, // Utilisation du paramètre title
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              height: 37.51 / 25, // Conversion de la hauteur de ligne
              color: Colors.black,
              fontFamily:
                  'Poppins', // Assurez-vous que Poppins est disponible dans les assets
            ),
          ),
          const Spacer(),
          Row(
            children: [
              _buildIcon(Iconsax.search_normal),
              _buildIcon(Iconsax.grid_3),
              const SizedBox(width: 10),
              _buildIcon(Iconsax.notification),
              _buildIcon(Iconsax.setting_2),
              _buildIcon(Iconsax.message),
              const CircleAvatar(
                radius: 20, // Même taille que les icônes
                backgroundImage: AssetImage("assets/images/logo_small.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNineDotsIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          3,
          (_) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (_) => _buildDot()),
              )),
    );
  }

  Widget _buildDot() {
    return Container(
      margin: const EdgeInsets.all(2), // Espacement entre les points
      width: 4,
      height: 4,
      decoration: const BoxDecoration(
        color: Colors.black, // Couleur des points
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4), // Espacement
      child: CircleAvatar(
        radius: 20, // Même taille que l'avatar
        backgroundColor: Colors.grey.shade200,
        child: IconButton(
          icon: Icon(icon, color: Colors.black, size: 20), // Taille ajustée
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
