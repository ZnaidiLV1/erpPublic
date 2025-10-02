import 'package:biboo_pro/core/constants/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../core/services/hive_repository.dart';

class AddEditAnimatrice extends StatefulWidget {
  final bool? isEdit;
  final Map<String, dynamic>? child;

  const AddEditAnimatrice({
    super.key,
    this.isEdit,
    this.child,
  });

  @override
  State<AddEditAnimatrice> createState() => _AddChildrenState();
}

class _AddChildrenState extends State<AddEditAnimatrice> {
  // Controllers for all text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();


  // Payment / gender / class state
  int? selectedIndex;
  String selectedValue = "Male";
  String? selectedClass;
  String parentPhone = "";
  Uint8List? _avatarBytes;

  final List<String> items = [
    "Cache",
    "Chéque",
    "Virement",
    "Versement",
  ];

  // Use the classes list you provided earlier
  final List<String> _classes = const [
    // Crèche
    'B','TP','PPS',
    // Maternelle
    'TPS','PS','MS','GS',
    // Préparatoire
    'CP',
    // Garderie scolaire
    'CE1','CE2','CM1','CM2','C6'
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
  late String schoolType ;
  String? _classSelected;

  @override
  void initState() {
    super.initState();
    schoolType = Hive.box(HiveRepository.preferencesBoxKey).get('school_type') ?? "maternelle";
    schoolType = Hive.box(HiveRepository.preferencesBoxKey).get('school_type') ?? "maternelle";
    final classes = schoolClasses[schoolType] ?? _classes;

    if (classes.isNotEmpty) {
      _classSelected = classes.first;
    }

    // If editing, prefill controllers from widget.child
    if (widget.isEdit == true && widget.child != null) {
      final child = widget.child!;

      nameController.text = (child['parentName'] ?? child['parent'] ?? '').toString();
      emailController.text = (child['parentEmail'] ?? child['parentEmail'] ?? '').toString();
      parentPhone = (child['parentNumber'] ?? child['parentNumber'] ?? '').toString();


      _dateController.text = (child['birth'] ?? child['birthDate'] ?? '').toString();

      selectedValue = (child['gender'] ?? child['sex'] ?? selectedValue).toString();
      selectedClass = (child['class'] ?? child['classe'] ?? selectedClass)?.toString();

    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();

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
      });
    }
  }

  void _handleSubmit() {}


  @override
  Widget build(BuildContext context) {
    final List<String> classes = schoolClasses[schoolType] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child:
          ListView(
            scrollDirection: Axis.vertical,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: IconButton(icon: const Icon(Icons.close), onPressed: () {
                      Navigator.pop(context);
                    },),
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
                        "Personal Details",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: HexColor("#303972")),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.7, child: const Divider()),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Nom", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: HexColor("#303972"))),
                                  Text(" *", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: HexColor("#FD5353"))),
                                ],
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.32,
                                child: TextFormField(
                                  controller: nameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Le nom du parent est requis';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Entrez le nom de parent",
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 40),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Presnom", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: HexColor("#303972"))),
                                  Text(" *", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: HexColor("#FD5353"))),
                                ],
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.32,
                                child: TextFormField(
                                  controller: nameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Le nom  est requis';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Entrez le nom",
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Email", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: HexColor("#303972"))),
                                  Text(" *", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: HexColor("#FD5353"))),
                                ],
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.32,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'L\'email  est requis';
                                    }
                                    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                    if (!emailRegExp.hasMatch(value.trim())) {
                                      return 'Veuillez entrer une adresse e-mail valide';
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: "Entrez l’email",
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 40),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Numéro de téléphone", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: HexColor("#303972"))),
                                  Text(" *", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: HexColor("#FD5353"))),
                                ],
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.32,
                                child: IntlPhoneField(
                                  validator: (value) {
                                    if (value == null || value.number.isEmpty) {
                                      return 'Le numéro de téléphone est requis';
                                    }
                                    if (value.number.length < 8) {
                                      return 'Numéro de téléphone invalide';
                                    }
                                    return null;
                                  },
                                  disableLengthCheck: true,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  decoration: InputDecoration(

                                    hintText: "Numéro de téléphone",
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                                    ),
                                  ),
                                  initialCountryCode: 'TN',
                                  initialValue: parentPhone.isNotEmpty ? parentPhone : null,
                                  onChanged: (phone) {
                                    parentPhone = phone.completeNumber;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Address", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: HexColor("#303972"))),
                                  Text(" *", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: HexColor("#FD5353"))),
                                ],
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.32,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'L\'email du parent est requis';
                                    }
                                    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                    if (!emailRegExp.hasMatch(value.trim())) {
                                      return 'Veuillez entrer une adresse e-mail valide';
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: "Entrez l’email d'annimateure",
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 40),
                          SizedBox(
                            width: 250,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Photo", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: HexColor("#303972"))),
                                    Text(" *", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: HexColor("#FD5353"))),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 104,
                                  width: 104,
                                  child:_avatarBytes == null
                                      ? Image.asset('assets/images/avatar_1.png', fit: BoxFit.cover)
                                      : Image.memory(_avatarBytes!, fit: BoxFit.cover),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Implement file picker logic here
                                        _pickAvatar();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: HexColor("#303972"),
                                        minimumSize: const Size(100, 48),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                      ),
                                      child: const Text("Choisir un fichier", style: TextStyle(color: Colors.white, fontSize: 12)),
                                    ),
                                    OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        minimumSize: const Size(100, 48),
                                        side: const BorderSide(color: Colors.red, width: 2),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                      ),
                                      child: const Text("Annuler", style: TextStyle(color: Colors.red, fontSize: 12)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Date de naissance", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: HexColor("#303972"))),
                                  Text(" *", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: HexColor("#FD5353"))),
                                ],
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: TextFormField(
                                  controller: _dateController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: "Choisir date",
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(Iconsax.calendar, color: HexColor("#70C4CF")),
                                      onPressed: () => _selectDate(context),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 130),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Classe", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: HexColor("#303972"))),
                                  Text(" *", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: HexColor("#FD5353"))),
                                ],
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Container(
                                  color: Colors.white,
                                  child: DropdownButtonFormField<String>(
                                    value: _classSelected,
                                    decoration: InputDecoration(
                                      hintText: "Séléctionner classe",
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                                      ),
                                    ),
                                    items: classes
                                        .map((String value) => DropdownMenuItem<String>(value: value, child: Text(value)))
                                        .toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _classSelected = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Lieu de naissance", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: HexColor("#303972"))),
                                  Text(" *", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: HexColor("#FD5353"))),
                                ],
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.32,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Le nom d'annimatrice est requis";
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: "Lieu de naissance",
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 40),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Mot de passe", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: HexColor("#303972"))),
                                  Text(" *", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: HexColor("#FD5353"))),
                                ],
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Mot de passe est requis";
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: "Mot de passe",
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                                    ),
                                  ),
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
              const SizedBox(height: 50),

              Text(
                "Education Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: HexColor("#303972")),
              ),
              const SizedBox(height: 10),
              SizedBox(width: MediaQuery.of(context).size.width * 0.7, child: const Divider()),

              const SizedBox(height: 20),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Universite", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: HexColor("#303972"))),
                          Text(" *", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: HexColor("#FD5353"))),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.32,
                        child: TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'champ est requis';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Entrez l’universite",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Diplome", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: HexColor("#303972"))),
                          Text(" *", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: HexColor("#FD5353"))),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.32,
                        child: TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'champ et requis';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "diplome",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Date de debuit et date de fin", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: HexColor("#303972"))),
                          Text(" *", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: HexColor("#FD5353"))),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.32,
                        child: TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'champ est requis';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Region", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: HexColor("#303972"))),
                          Text(" *", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: HexColor("#FD5353"))),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.32,
                        child: TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'champ et requis';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "region",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
                        const SizedBox(height: 50),
                        Row(
                          children: [
                            const Spacer(),
                            OutlinedButton(
                              onPressed: () { Navigator.pop(context); },
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(150, 48),
                                side: BorderSide(color: HexColor("#70C4CF"), width: 2),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              ),
                              child: Text("Annuler", style: TextStyle(color: HexColor("#70C4CF"))),
                            ),
                            const SizedBox(width: 30),
                            ElevatedButton(
                              onPressed: _handleSubmit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor("#70C4CF"),
                                minimumSize: const Size(150, 48),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              ),
                              child: Text(widget.isEdit == true ? "Mettre à jour" : "Ajouter", style: const TextStyle(color: Colors.white)),
                            ),
                            const SizedBox(width: 30),
                          ],
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
    );
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
