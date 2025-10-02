import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../core/constants/colors.dart';
import '../../../core/services/hive_repository.dart';

class AddChildren extends StatefulWidget {
  final VoidCallback onCancelPressed;
  final bool? isEdit;
  const AddChildren({super.key, required this.onCancelPressed, this.isEdit});

  @override
  State<AddChildren> createState() => _AddChildrenState();
}

class _AddChildrenState extends State<AddChildren> {
  final TextEditingController _dateController = TextEditingController();

  String? _classSelected;
  int? selectedIndex;
  String selectedValue = "Male";
  Uint8List? _avatarBytes;

  final List<String> items = [
    "Cache",
    "Chéque",
    "Virement",
    "Versement",
  ];

  // Map of school types to their respective classes
  final Map<String, List<String>> schoolClasses = {
    "creche": [
      "B - Bébés (6 – 12 mois)",
      "TP - Tout-petits (12 – 24 mois)",
      "PPS - Pré-Petite Section (2 – 3 )",
    ],
    "maternelle": [
      "TPS - Toute Petite Section (2 – 3)",
      "PS - Petite Section (3 – 4)",
      "MS - Moyenne Section (4 – 5)",
      "GS - Grande Section (5 – 6)",
    ],
    "preparatoire": [
      "CP - Classe Préparatoire (6 – 7)",
    ],
    "garderie": [
      "CP", "CE1", "CE2", "CM1", "CM2", "C6",
    ],
  };
  late String schoolType = 'maternelle';

  @override
  void initState() {
    super.initState();
    schoolType =
        Hive.box(HiveRepository.preferencesBoxKey).get('school_type') ?? "maternelle";

    final classes = schoolClasses[schoolType] ?? [];
    if (classes.isNotEmpty) {
      _classSelected = classes.first;
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
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
              onSurface: Colors.black,
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

        DateTime today = DateTime.now();
        int age = today.year - pickedDate.year;
        if (today.month < pickedDate.month ||
            (today.month == pickedDate.month && today.day < pickedDate.day)) {
          age--;
        }

        if (age < 2) {
          schoolType = "creche";
        } else if (age >= 2 && age < 5) {
          schoolType = "maternelle";
        } else if (age >= 5 && age < 6) {
          schoolType = "preparatoire";
        } else {
          schoolType = "garderie";
        }

        final List<String> classes = schoolClasses[schoolType] ?? [];

        if (classes.isNotEmpty) {
          _classSelected = classes.first;
        }
      });
  }}

  @override
  Widget build(BuildContext context) {
    final List<String> classes = schoolClasses[schoolType] ?? [];
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
      scrollDirection: Axis.vertical,
      children: [
         Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: IconButton(onPressed: widget.onCancelPressed, icon: const Icon(Icons.close)),
            ),
          ],
        ),
        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Parents Details",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: HexColor("#303972")),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: const Divider(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Nom et Prénom",
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
                          width: MediaQuery.of(context).size.width * 0.32,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Entrez le nom de parent",
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
                      ],
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Numéro de téléphone",
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
                          width: MediaQuery.of(context).size.width * 0.32,
                          child: IntlPhoneField(
                            disableLengthCheck: true,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                              hintText: "Numéro de téléphone",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(
                                    color: HexColor("#70C4CF"), width: 2),
                              ),
                            ),
                            initialCountryCode: 'TN',
                            onChanged: (phone) {
                              debugPrint(phone.completeNumber);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Email",
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
                          width: MediaQuery.of(context).size.width * 0.32,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Entrez l’email de parent",
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
                      ],
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Méthode de Payment",
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
                          child: Row(
                            children: List.generate(items.length, (index) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CheckboxTheme(
                                    data: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            3.5), // Adjust the radius as needed
                                        side: BorderSide(
                                            color: HexColor("#C4C4C4"),
                                            width: 2),
                                      ),
                                    ),
                                    child: Checkbox(
                                      activeColor: HexColor("#70C4CF"),
                                      value: selectedIndex == index,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          selectedIndex =
                                              value == true ? index : null;
                                        });
                                      },
                                    ),
                                  ),
                                  Text(
                                    items[index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: HexColor("#A098AE")),
                                  ),
                                  const SizedBox(width: 20),
                                ],
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox()
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Enfants Details",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: HexColor("#303972")),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: const Divider(),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Photo",
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
                    height: 20,
                  ),
                  SizedBox(
                    height: 104,
                    width: 104,
                    child: _avatarBytes == null
                          ? Image.asset('assets/images/avatar_1.png', fit: BoxFit.cover)
                          : Image.memory(_avatarBytes!, fit: BoxFit.cover)),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _pickAvatar();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor("#303972"),
                          minimumSize: const Size(100, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          "Choisir un fichier",
                          style: TextStyle(color: Colors.white,fontSize: 12),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: (){
                          setState(() {
                            _avatarBytes = null;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(100, 48),
                          side: const BorderSide(color: Colors.red, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          "Annuler",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Nom et Prénom",
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
                              decoration: InputDecoration(
                                hintText: "Entrez le nom de l'enfant ",
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
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                            width: MediaQuery.of(context).size.width * 0.25,
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
                                  icon: Icon(Iconsax.calendar, color: HexColor("#70C4CF"),),
                                  onPressed: () => _selectDate(context),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Genre",
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
                            child: Container(
                              color: Colors.white,
                              child: DropdownButtonFormField<String>(
                                value: selectedValue, // Set default value
                                decoration: InputDecoration(
                                  hintText: "Séléctionner l’age",
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
                                items: ["Male", "Femelle"]
                                    .map((String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ))
                                    .toList(),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      selectedValue = newValue;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Classe",
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

                          const SizedBox(height: 15),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: DropdownButtonFormField<String>(
                              value: _classSelected,
                              decoration: InputDecoration(
                                hintText: "Séléctionner classe",
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
                              items: classes
                                  .map((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                                  .toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _classSelected = newValue;

                                });
                              },
                            ),
                          ),                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Frais d’abonnement",
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
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                hintText: "Frais d’abonnement",
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
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Remise sur frais d’abonnement",
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
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                hintText: "Remise sur frais d’abonnement",
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
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Frais d’inscription",
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
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                hintText: "Frais d’inscription",
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
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Remise sur frais d’inscription",
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
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                hintText: "Remise sur frais d’inscription",
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
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Hive.box(HiveRepository.preferencesBoxKey).get('transport_service') == true ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Frais de transport",
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
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                hintText: "Frais de transport",
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
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Remise sur frais de transport",
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
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                hintText: "Remise sur frais de transport",
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
                        ],
                      ),
                    ],
                  ):
                  const SizedBox(),
                  const SizedBox(height: 50,),
                  Row(
                    children: [
                      const Spacer(),
                      OutlinedButton(
                        onPressed:  widget.onCancelPressed,
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(150, 48),
                          side: BorderSide(color: HexColor("#70C4CF"), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text(
                          "Annuler",
                          style: TextStyle(color: HexColor("#70C4CF")),
                        ),
                      ),
                      const SizedBox(width: 30,),
                      ElevatedButton(
                        onPressed: () {
                          // Handle form submission
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor("#70C4CF"),
                          minimumSize: const Size(150, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          "Ajouter",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 30,),
                    ],
                  ),
                  const SizedBox(height: 50,),
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }
  Future<void> _pickAvatar() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _avatarBytes = result.files.first.bytes;
      });
    }
  }
}
