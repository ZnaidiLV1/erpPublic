import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class ProgressionFiltersWidget extends StatefulWidget {
  @override
  _ProgressionFiltersWidgetState createState() =>
      _ProgressionFiltersWidgetState();
}

class _ProgressionFiltersWidgetState extends State<ProgressionFiltersWidget> {
  String _selectedView = 'Tous les fiches';
  String _selectedDateFilter = 'Date';
  String _selectedSection = 'Section d\'age';
  String _selectedTeacher1 = 'Nesrine Dziri';
  String _selectedTeacher2 = 'Marwa Jbarra';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Dropdown pour la date
          Container(
            width: 140,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
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
                    items: ['Date 1', 'Date 2', 'Date 3'].map((String value) {
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
          const SizedBox(width: 8),

          // Dropdown pour le club
          Container(
            width: 170,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const Icon(Icons.sports_soccer, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox(),
                    hint: const Text("Séction d’age",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            fontFamily: 'Poppins')),
                    items: ['age 1', 'age2', 'age 3'].map((String value) {
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
          const SizedBox(width: 8),

          // Dropdown pour le prix
          Container(
            width: 120,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const Icon(Icons.person, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox(),
                    hint: const Text('enfant',
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            fontFamily: 'Poppins')),
                    items: ['nesrine', 'hamma', 'kamel'].map((String value) {
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
          const SizedBox(width: 8),

          // Dropdown pour l'animateur
          Container(
            width: 170,
            height: 32,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: const SizedBox(),
                      hint: const Text('Animatrise',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              fontFamily: 'Poppins')),
                      items: ['Animateur 1', 'Animateur 2', 'Animateur 3']
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
          ),
          const Spacer(),

          // Barre de recherche
          Expanded(
            child: TextField(
              style: const TextStyle(
                  fontSize: 14), // Ajustement de la taille du texte
              decoration: InputDecoration(
                hintText: 'Rechercher...',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: const Icon(Icons.search,
                    size: 20, color: Colors.grey), // Icône intégrée
                filled: true,
                fillColor: bGris9, // Couleur de fond personnalisée
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24), // Radius de 24
                  borderSide:
                      BorderSide.none, // Suppression de la bordure par défaut
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(
                      color: Colors.grey), // Bordure grise par défaut
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                      color: bGris9, width: 2), // Bordure bleue au focus
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
