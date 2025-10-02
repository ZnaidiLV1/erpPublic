import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/di/getIt.dart';
import '../../../core/services/expense_service.dart';
import '../../../core/shared/dialogs/failure_dialog.dart';
import '../../../domain/models/expense/expense_model.dart';

class DepenseSettingsPanel extends StatefulWidget {
  final Function()? onClose;
  final Function()? onSave;
  final Function()? onCancel;
  final ExpenseModel expense;

  const DepenseSettingsPanel({
    Key? key,
    this.onClose,
    this.onSave,
    this.onCancel,
    required this.expense,
  }) : super(key: key);

  @override
  State<DepenseSettingsPanel> createState() => _DepenseSettingsPanelState();
}

class _DepenseSettingsPanelState extends State<DepenseSettingsPanel> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _subCategoryController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _timeController = TextEditingController();


  String? category;
  String? subCategory;

  @override
  void initState() {
    _dateController = TextEditingController(text: widget.expense.date);
    _categoryController = TextEditingController(text: widget.expense.category);
    _subCategoryController =
        TextEditingController(text: widget.expense.subCategory);
    _detailsController = TextEditingController(
        text: widget.expense.details);
    _amountController = TextEditingController(text: widget.expense.ammount);
    _timeController = TextEditingController(text: widget.expense.time);
    category = widget.expense.category;
    subCategory = widget.expense.subCategory;
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _categoryController.dispose();
    _subCategoryController.dispose();
    _detailsController.dispose();
    _amountController.dispose();
    _timeController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 429,
      height: 1024,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(6),
          bottomRight: Radius.circular(6),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header and Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Modifier dépense",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: widget.onClose,
                icon: Icon(
                  Icons.close,
                  color: Color.fromRGBO(46, 38, 61, 0.6),
                  size: 24,
                ),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Form Fields in Scrollable Area
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Date de depense",
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
                  SizedBox(height: 23),

                  // Category Field
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
                  SizedBox(height: 23),

                  // Sub-Category Field
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
                  SizedBox(height: 23),

                  // Details Field
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
                    child: TextFormField(
                      controller: _detailsController,
                      decoration: InputDecoration(
                        hintText: "Entrez votre details",
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
                  SizedBox(height: 23),

                  // Amount Field
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
                        hintText: "Entrez votre montant",
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
                  SizedBox(height: 23),

                  // Time Field
                  Row(
                    children: [
                      Text(
                        "Heure de dépense",
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
                  SizedBox(height: 23),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildButton(
                        text: "Annuler",
                        Color: Color(0xFFA098AE),
                        onPressed: widget.onCancel,
                      ),
                      _buildButton(
                        text: "Modifier",
                        Color: Color(0xFF21A166),
                        onPressed: (){
                          if (category == null ||
                              subCategory == null ||
                              _detailsController.text.isEmpty ||
                              _amountController.text.isEmpty ||
                              _dateController.text.isEmpty ||
                              _timeController.text.isEmpty) {
                            showFailureDialog(
                                context, "Veuillez remplir tous les champs");
                          } else {
                            ExpenseModel expense = ExpenseModel(
                                id: widget.expense.id,
                                category: category!,
                                subCategory: subCategory!,
                                details: _detailsController.text,
                                ammount: _amountController.text,
                                date: _dateController.text,
                                time: _timeController.text);
                            getIt<ExpenseService>().updateExpense(expense.toJson());
                          }
                          widget.onSave!();
                          },
                      ),
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

  Widget _buildButton({
    required String text,
    required Color Color,
    required VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: 156,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.85),
          ),
        ),
      ),
    );
  }
}
