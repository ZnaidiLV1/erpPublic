import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sidebarx/sidebarx.dart';

import '../constants/colors.dart';

class CustomSideBar extends StatefulWidget {
   const CustomSideBar({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  State<CustomSideBar> createState() => _CustomSideBarState();
}

class _CustomSideBarState extends State<CustomSideBar> {
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: widget._controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(5),
        itemPadding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: Colors.white.withOpacity(0.15),
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        hoverTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white.withOpacity(0.15),
          ),
          gradient: LinearGradient(
            colors: [Colors.white.withOpacity(0.15), Colors.white.withOpacity(0.2)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: primary,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 80, // Réduit la hauteur du header pour laisser plus de place aux items
          child: Padding(
            padding: const EdgeInsets.all(12.0), // Réduit le padding
            child: Image.asset('assets/images/logo_side_bar.png'),
          ),
        );
      },
      // SOLUTION 1: Envelopper les items dans un Scrollable
      items: _buildScrollableItems(),
    );
  }

  // Méthode pour créer les items avec gestion du scroll
  List<SidebarXItem> _buildScrollableItems() {
    return [
      SidebarXItem(
        icon: Iconsax.home_2,
        label: 'Tableau de bord',
        onTap: () {
          debugPrint('Home');
        },
      ),
      const SidebarXItem(
        icon: Iconsax.teacher,
        label: 'Enfants',
      ),
      const SidebarXItem(
        icon: Iconsax.user,
        label: 'Animatrice',
      ),
      const SidebarXItem(
        icon: Icons.restaurant_menu_outlined,
        label: 'Cantine&Gouter',
      ),
      const SidebarXItem(
        icon: Iconsax.calendar_tick,
        label: 'Événement',
      ),
      const SidebarXItem(
        icon: Iconsax.buildings_2,
        label: 'Classe',
      ),
      const SidebarXItem(
        icon: Iconsax.calendar,
        label: 'Calendrier', // Corrigé l'orthographe
      ),
      const SidebarXItem(
        icon: Iconsax.driving,
        label: 'Chauffeur',
      ),
      const SidebarXItem(
        icon: Iconsax.ticket,
        label: 'Absence',
      ),
      const SidebarXItem(
        icon: Iconsax.health,
        label: 'Planning',
      ),
      const SidebarXItem(
        icon: Iconsax.receipt,
        label: 'Facturation',
      ),
      const SidebarXItem(
        icon: Iconsax.message,
        label: 'Discussion',
      ),
      const SidebarXItem(
        icon: Iconsax.chart_1,
        label: 'Finance',
      ),
      const SidebarXItem(
        icon: Iconsax.award,
        label: 'Badges',
      ),
      const SidebarXItem(
        icon: Iconsax.ranking,
        label: 'Progression suivie',
      ),
      const SidebarXItem(
        icon: Iconsax.smileys,
        label: 'Clubs',
      ),
    ];
  }

  final divider = Divider(color: Colors.white.withOpacity(0.3), height: 1);

  Color primary = HexColor("#4CB6AC");
}