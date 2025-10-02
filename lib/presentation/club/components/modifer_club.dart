import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/components/app_bar.dart';
import '../../../core/constants/colors.dart';

class ClubModifScreen extends StatefulWidget {
  const ClubModifScreen({super.key});

  @override
  _ClubModifScreenState createState() => _ClubModifScreenState();
}

class _ClubModifScreenState extends State<ClubModifScreen> {
  String? selectedClub;
  String? selectedOption;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  DateTime? selectedDate;
  String? _selectedInstructor;
  String imageUrl = 'assets/images/football.png';

  final List<String> daysOfWeek = [
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samedi',
    'Dimanche'
  ];
  String? selectedDay;
  final List<String> clubs = [
    'Club de football',
    'Club de basketball',
    'Club de natation',
    'Club de tennis',
    'Club de danse',
    'Club de musique'
  ];
  List<String> filteredClubs = [];
  TextEditingController _priceController = TextEditingController();
  final List<String> _instructors = [
    'Sélectionnez un instructeur',
    'Mohamed Hamdi',
    'Ali Ben Salah',
    'Sara Toumi'
  ];

  @override
  void initState() {
    super.initState();
    filteredClubs = clubs;
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  void _filterClubs(String query) {
    setState(() {
      filteredClubs = clubs
          .where((club) => club.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  InputDecoration _roundedInputDecoration(String label, String helper) {
    return InputDecoration(
      labelText: label,
      helperText: helper,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(24),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DashboardHeader(title: "Ajouter Clubs"),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Partie gauche (Liste des clubs)
            Container(
              width: 220,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      onChanged: _filterClubs,
                      decoration: _roundedInputDecoration(
                        "Rechercher des clubs...",
                        "Tapez pour filtrer les clubs",
                      ).copyWith(prefixIcon: Icon(Icons.search)),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredClubs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filteredClubs[index],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  "Sam, 13:00PM-17:00PM\nDim, 10:00PM-16:00PM",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {},
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const VerticalDivider(color: Colors.grey, thickness: 2),
            const SizedBox(width: 16),

            // Partie droite (Formulaire)
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    // Assure-toi que le chemin est correct

                    Container(
                      width: 862,
                      height: 280,
                      decoration: BoxDecoration(
                        color:
                            imageUrl.isNotEmpty ? Colors.transparent : bBlack06,
                        borderRadius: BorderRadius.circular(24),
                        image: imageUrl.isNotEmpty
                            ? DecorationImage(
                                image: AssetImage(
                                    imageUrl), // Charge l'image des assets
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // Action pour importer une image
                                  },
                                  icon:
                                      Icon(Icons.image, size: 20, color: bGris),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Action pour modifier l'image
                                  },
                                  icon:
                                      Icon(Icons.edit, size: 20, color: bGris),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Action pour supprimer l'image
                                  },
                                  icon: Icon(Icons.delete,
                                      size: 20, color: bGris),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 46),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 600),
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              DropdownButtonFormField<String>(
                                decoration: _roundedInputDecoration(
                                  "Catégorie de club",
                                  "Sélectionnez la catégorie appropriée",
                                ),
                                value: selectedClub,
                                items: const [
                                  DropdownMenuItem(
                                    value: "Sport",
                                    child: Text("Sport"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Musique",
                                    child: Text("Musique"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Danse",
                                    child: Text("Danse"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Théâtre",
                                    child: Text("Théâtre"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Autres",
                                    child: Text("Autres"),
                                  ),
                                ],
                                onChanged: (value) =>
                                    setState(() => selectedClub = value),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                decoration: _roundedInputDecoration(
                                  "Titre de l'activité",
                                  "Entrez le nom officiel du club",
                                ).copyWith(prefixIcon: Icon(Icons.title)),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                decoration: _roundedInputDecoration(
                                  "Capacité",
                                  "Nombre maximum de participants",
                                ).copyWith(prefixIcon: Icon(Icons.group)),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                              const SizedBox(height: 16),
                              DropdownButtonFormField<String>(
                                decoration: _roundedInputDecoration(
                                  "Instructeur",
                                  "Choisissez l'instructeur responsable",
                                ),
                                value: _selectedInstructor,
                                items: _instructors.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) =>
                                    setState(() => _selectedInstructor = value),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                maxLines: 3,
                                decoration: _roundedInputDecoration(
                                  "Description du club",
                                  "Décrivez les activités du club",
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: RadioListTile(
                                      title: const Text("Gratuit"),
                                      value: "Gratuit",
                                      groupValue: selectedOption,
                                      onChanged: (value) => setState(
                                          () => selectedOption = value),
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      title: const Text("Payant"),
                                      value: "Payant",
                                      groupValue: selectedOption,
                                      onChanged: (value) => setState(
                                          () => selectedOption = value),
                                    ),
                                  ),
                                  if (selectedOption == "Payant")
                                    Flexible(
                                      child: TextField(
                                        controller: _priceController,
                                        decoration: _roundedInputDecoration(
                                          "Prix",
                                          "Prix en euros",
                                        ).copyWith(
                                            prefixIcon: Icon(Icons.euro)),
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 16,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                    onPressed: () async {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      setState(() => startTime = time);
                                    },
                                    child: Text(startTime == null
                                        ? "Choisir l'heure de début"
                                        : " ${startTime!.format(context)}"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                    onPressed: () async {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      setState(() => endTime = time);
                                    },
                                    child: Text(endTime == null
                                        ? "Choisir l'heure de fin"
                                        : endTime!.format(context)),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Choisir un jour"),
                                        content: SizedBox(
                                          width: double.maxFinite,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: daysOfWeek.length,
                                            itemBuilder: (context, index) =>
                                                ListTile(
                                              title: Text(daysOfWeek[index]),
                                              onTap: () {
                                                setState(() => selectedDay =
                                                    daysOfWeek[index]);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: Text(selectedDay == null
                                        ? "Choisir un jour"
                                        : "$selectedDay"),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32, vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      backgroundColor: Colors.grey[300],
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Annuler"),
                                  ),
                                  const SizedBox(width: 16),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32, vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      backgroundColor: Colors.blue,
                                    ),
                                    onPressed: () {},
                                    child: const Text("Modifier",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
