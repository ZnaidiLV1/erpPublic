import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/di/getIt.dart';
import '../../../core/services/revenue_service.dart';
import '../../../core/shared/dialogs/failure_dialog.dart';
import '../../../core/shared/dialogs/success_dialog.dart';
import '../../../domain/models/revenue/revenue_model.dart';

class AddRevenue extends StatefulWidget {
  final VoidCallback onCancelPressed;

  const AddRevenue({super.key, required this.onCancelPressed});

  @override
  _AddRevenueState createState() => _AddRevenueState();
}

class _AddRevenueState extends State<AddRevenue> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String? category;
  String? subCategory;
  String? details;

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: HexColor("#70C4CF"),
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: HexColor("#70C4CF"), // Primary color
            hintColor: HexColor("#70C4CF"), // Accent color
            colorScheme: ColorScheme.light(
              primary: HexColor("#70C4CF"), // Header color
              onPrimary: Colors.white, // Header text color
              surface: Colors.white, // Background color
              onSurface: Colors.black, // Time text color
            ),
            buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.light(primary: HexColor("#70C4CF")),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final String formattedTime = picked.format(context); // Format time
      _timeController.text = formattedTime; // Update text field
    }
  }

  void _clearForm() {
    _dateController.clear();
    _timeController.clear();
    _amountController.clear();
    setState(() {
      category = null;
      subCategory = null;
      details = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Dépense Détails'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(thickness: 1, color: Colors.grey),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Catégories",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#303972")),
                          ),
                          Text(
                            " *",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: HexColor("#FD5353")),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 50,
                        child: Container(
                          color: Colors.white,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              hintText: "Sélectionner votre catégorie",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(
                                  color: HexColor("#70C4CF"),
                                  width: 2,
                                ),
                              ),
                            ),
                            items: ["catégorie 1", "catégorie 2", "catégorie 3"]
                                .map(
                                  (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ),
                            )
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                category = newValue;
                              });
                            },
                            value: category,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            "Date de naissance",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#303972")),
                          ),
                          Text(
                            " *",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: HexColor("#FD5353")),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Choisir date",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(
                                color: HexColor("#70C4CF"),
                                width: 2,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Iconsax.calendar,
                                color: HexColor("#70C4CF"),
                              ),
                              onPressed: () => _selectDate(context),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            "Détails",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#303972")),
                          ),
                          Text(
                            " *",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: HexColor("#FD5353")),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 50,
                        child: Container(
                          color: Colors.white,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              hintText: "Sélectionner votre Détails",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(
                                  color: HexColor("#70C4CF"),
                                  width: 2,
                                ),
                              ),
                            ),
                            items: ["Details 1", "Details 2", "Details 3"]
                                .map(
                                  (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ),
                            )
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                details = newValue;
                              });
                            },
                            value: details,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Sous Catégories",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#303972")),
                          ),
                          Text(
                            " *",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: HexColor("#FD5353")),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 50,
                        child: Container(
                          color: Colors.white,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              hintText: "Sélectionner votre sous catégorie",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(
                                  color: HexColor("#70C4CF"),
                                  width: 2,
                                ),
                              ),
                            ),
                            items: [
                              "sous catégorie 1",
                              "sous catégorie 2",
                              "sous catégorie 3"
                            ]
                                .map(
                                  (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ),
                            )
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                subCategory = newValue;
                              });
                            },
                            value: subCategory,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            "Montant",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#303972")),
                          ),
                          Text(
                            " *",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: HexColor("#FD5353")),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: _amountController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*$')),
                            // Allows only numbers and a single dot
                          ],
                          decoration: InputDecoration(
                            hintText: "Entrez votre sous montant",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(
                                  color: HexColor("#70C4CF"), width: 2),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            "Heure de dépense*",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#303972")),
                          ),
                          Text(
                            " *",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: HexColor("#FD5353")),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: TextFormField(
                          controller: _timeController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Choisir l’heure",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(
                                color: HexColor("#70C4CF"),
                                width: 2,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Iconsax.timer_1,
                                  color: HexColor("#70C4CF")),
                              onPressed: () => _selectTime(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: widget.onCancelPressed,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF70C4CF),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF70C4CF)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text('Annuler'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (category == null ||
                        subCategory == null ||
                        details == null ||
                        _amountController.text.isEmpty ||
                        _dateController.text.isEmpty ||
                        _timeController.text.isEmpty) {
                      showFailureDialog(
                          context, "Veuillez remplir tous les champs");
                    } else {
                      RevenueModel revenue = RevenueModel(
                          id: 0,
                          category: category!,
                          subCategory: subCategory!,
                          details: details!,
                          ammount: _amountController.text,
                          date: _dateController.text,
                          time: _timeController.text);
                      getIt<RevenueService>().addRevenue(revenue.toJson());
                      showSuccessDialog(context, "Revenue ajoutée !");
                      _clearForm();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF70C4CF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text('Enregistrer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
