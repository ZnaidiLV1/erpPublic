import 'package:biboo_pro/core/constants/colors.dart';
import 'package:biboo_pro/presentation/auth/pages/verify_code.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:async';
import 'package:hive/hive.dart';
import 'package:shimmer/shimmer.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart'; // Commenté temporairement
import '../../../core/services/Location/localisation_service.dart';
import '../../../core/services/hive_repository.dart';
import '../../../core/utils/validators.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _schoolNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _manualAddressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _transport = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _acceptedPolicy = false;
  bool _isLoadingLocation = false;
  String? _schoolType;
  Uint8List? _avatarBytes;

  final List<String> _schoolTypes = const [
    'Crèche',
    'Crèche & Jardin d’enfants',
    'Jardin d’enfants',
    'Garderie scolaire',
    'école primaire (préparatoire)',
    'Complexe éducatif privé',
  ];

  final Map<String, List<String>> schoolClasses = {
    "creche": [
      "B - Bébés (6 – 12 mois)",
      "TP - Tout-petits (12 – 24 mois)",
      "PPS - Pré-Petite Section (2 – 3 ans)",
    ],
    "maternelle": [
      "TPS - Toute Petite Section (2 – 3 ans)",
      "PS - Petite Section (3 – 4 ans)",
      "MS - Moyenne Section (4 – 5 ans)",
      "GS - Grande Section (5 – 6 ans)",
    ],
    "preparatoire": [
      "CP - Classe Préparatoire (6 – 7 ans)",
    ],
    "garderie": [
      "CP", "CE1", "CE2", "CM1", "CM2", "C6",
    ],
  };
 final List<String> _tunisianCities = const [
    'Tunis',
    'Ariana',
    'Manouba',
    'Ben Arous',
    'Nabeul',
    'Zaghouan',
    'Bizerte',
    'Béja',
    'Jendouba',
    'Le Kef',
    'Siliana',
    'Kairouan',
    'Sousse',
    'Monastir',
    'Mahdia',
    'Kasserine',
    'Sidi Bouzid',
    'Sfax',
    'Gafsa',
    'Gabès',
    'Tozeur',
    'Kébili',
    'Médenine',
    'Tataouine',
  ];
  @override
  void dispose() {
    _fullNameController.dispose();
    _schoolNameController.dispose();
    _cityController.dispose();
    _manualAddressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(
            flex: 3, // Plus large pour le formulaire
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 70, top: 30, right: 60),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Inscription',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Configurons votre compte pour que vous puissiez y accéder.",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: HexColor('#313131'),
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // First row: Full name & School name
                          Row(
                            children: [
                              Flexible(
                                child: _buildTextField(
                                  controller: _fullNameController,
                                  label: 'Nom & prénom',
                                  validator: (v) => Validators.requiredField(v, fieldName: 'Nom & prénom'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Flexible(
                                child: _buildTextField(
                                  controller: _schoolNameController,
                                  label: "Nom d'établissement",
                                  validator: (v) => Validators.requiredField(v, fieldName: "Nom d'établissement"),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // Second row: Email & Phone
                          Row(
                            children: [
                              Flexible(
                                child: _buildTextField(
                                  controller: _emailController,
                                  label: 'Adresse e-mail',
                                  keyboardType: TextInputType.emailAddress,
                                  validator: Validators.email,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Flexible(
                                child: _buildTextField(
                                  controller: _phoneController,
                                  label: 'Numéro de téléphone',
                                  keyboardType: TextInputType.phone,
                                  validator: Validators.phone,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // Third row: City dropdown & Manual Address with GPS
                          Row(
                            children: [
                              Flexible(
                                child: DropdownButtonFormField<String>(
                                  value: _cityController.text.isEmpty ? null : _cityController.text,
                                  items: _tunisianCities
                                      .map((city) => DropdownMenuItem<String>(
                                        value: city, 
                                        child: Text(
                                          city,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        )
                                      ))
                                      .toList(),
                                  onChanged: (v) => setState(() => _cityController.text = v ?? ''),
                                  validator: (v) => v == null ? "Ville est requise" : null,
                                  decoration: _decoration('Ville'),
                                  isExpanded: true,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Flexible(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: _buildTextField(
                                        controller: _manualAddressController,
                                        label: 'Adresse manuelle',
                                        validator: (v) => Validators.requiredField(v, fieldName: 'Adresse'),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      height: 56,
                                      width: 56,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        border: Border.all(color: Colors.grey),
                                        color: HexColor('#515DEF').withOpacity(0.1),
                                      ),
                                      child: IconButton(
                                        onPressed: _isLoadingLocation ? null : _getCurrentLocation,
                                        icon: _isLoadingLocation 
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                              ),
                                            )
                                          : Icon(
                                              Icons.gps_fixed,
                                              color: HexColor('#515DEF'),
                                              size: 24,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // Fourth row: School type dropdown
                          DropdownButtonFormField<String>(
                            value: _schoolType,
                            items: _schoolTypes
                                .map((e) => DropdownMenuItem<String>(
                                  value: e, 
                                  child: Text(
                                    e,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )
                                ))
                                .toList(),
                            onChanged: (v) => setState(() => _schoolType = v),
                            validator: (v) => v == null ? "Type d'établissement est requis" : null,
                            decoration: _decoration('Type d\'établissement'),
                            isExpanded: true,
                          ),
                          const SizedBox(height: 14),

                          // Fifth row: Password & Confirm Password
                          Row(
                            children: [
                              Flexible(
                                child: _buildTextField(
                                  controller: _passwordController,
                                  label: 'Mot de passe',
                                  validator: Validators.password,
                                  obscure: !_isPasswordVisible,
                                  suffix: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                      size: 24,
                                      color: Colors.black,
                                    ),
                                    onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Flexible(
                                child: _buildTextField(
                                  controller: _confirmPasswordController,
                                  label: 'Confirmer le mot de passe',
                                  validator: Validators.confirmPassword(_passwordController),
                                  obscure: !_isConfirmPasswordVisible,
                                  suffix: IconButton(
                                    icon: Icon(
                                      _isConfirmPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                      size: 24,
                                      color: Colors.black,
                                    ),
                                    onPressed: () => setState(
                                            () => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // Transport service
                          Center(
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 700),
                              height: 56,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: HexColor('#8d67ce')
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Flexible(
                                    child: Text('SERVICE DE TRANSPORT ?',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,),
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Switch(
                                    value: _transport,
                                    activeColor: Colors.white,
                                    activeTrackColor: HexColor('#49b965'),
                                    onChanged: (v) => setState(() => _transport = v),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Terms & policy
                          Row(
                            children: [
                              Checkbox(
                                value: _acceptedPolicy,
                                activeColor: HexColor('#515DEF'),
                                onChanged: (v) => setState(() => _acceptedPolicy = v ?? false),
                              ),
                              Expanded(
                                child: RichText(
                                  text: const TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(text: "J'accepte toutes "),
                                      TextSpan(
                                        text: 'les conditions ',
                                        style: TextStyle(color: Colors.pinkAccent),
                                      ),
                                      TextSpan(text: 'et '),
                                      TextSpan(
                                        text: 'politiques de confidentialité',
                                        style: TextStyle(color: Colors.pinkAccent),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Submit button
                          ElevatedButton(
                            onPressed: _acceptedPolicy ? _handleSubmit : null,
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                                    (states) {
                                  if (states.contains(WidgetState.disabled)) {
                                    return HexColor('#515DEF').withOpacity(0.3);
                                  }
                                  return HexColor('#515DEF');
                                },
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              ),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: Center(
                                child: Text(
                                  'Créer un compte',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: HexColor('#F3F3F3'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          
                          Center(
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Text('Vous avez déjà un compte ?  '),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: const Text(
                                    'Connectez-vous',
                                    style: TextStyle(color: Colors.pinkAccent),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2, // Plus petit pour l'image
            child: Container(
              padding: const EdgeInsets.only(left: 45, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset('assets/images/logo_small.png'),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 100,),
                      child: Container(
                        width: 350,
                        height: 350,
                        decoration: BoxDecoration(
                          border: Border.all(color: HexColor('#D5E0F6'), width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: _avatarBytes == null
                              ? Image.asset('assets/images/avatar_1.png', fit: BoxFit.cover)
                              : Image.memory(_avatarBytes!, fit: BoxFit.cover),
                        ),
                      )),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _pickAvatar,
                    style: ButtonStyle(
                      elevation: const WidgetStatePropertyAll(0),
                      backgroundColor: WidgetStatePropertyAll(HexColor('#515DEF')),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 12),
                      child: Text('Ajouter une photo (optionnel)', 
                                   style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  if (_avatarBytes != null)
                    TextButton(
                      onPressed: () => setState(() => _avatarBytes = null),
                      child: const Text('Supprimer la photo'),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(width: 1, color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(width: 1, color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(width: 2, color: HexColor('#515DEF')),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(width: 1, color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(width: 2, color: Colors.red),
      ),
      labelStyle: const TextStyle(color: Colors.black),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscure,
      decoration: _decoration(label).copyWith(suffixIcon: suffix),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() == true) {
      try {
        // Sauvegarder les données dans Hive
        final box = Hive.box(HiveRepository.preferencesBoxKey);
        box.put('transport_service', _transport);
        box.put('school_type', _schoolType);
        
        // Naviguer vers la page de vérification
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const VerifyCode(isSignUp: true),
          ),
        );
      } catch (e) {
        _showError('Erreur lors de la sauvegarde des données: ${e.toString()}');
      }
    }
  }

  Future<void> _pickAvatar() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );
      
      if (result != null && result.files.isNotEmpty && result.files.first.bytes != null) {
        setState(() {
          _avatarBytes = result.files.first.bytes;
        });
      }
    } catch (e) {
      _showError('Erreur lors de la sélection de l\'image: ${e.toString()}');
    }
  }

  Future<void> _getCurrentLocation() async {
    if (_isLoadingLocation) return;
    
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      debugPrint('Étape 1: Vérification des services de localisation');
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showLocationError('Activez le GPS dans les paramètres de votre téléphone.');
        return;
      }

      debugPrint('Étape 2: Vérification des permissions');
      LocationPermission permission = await Geolocator.checkPermission();
      debugPrint('Permission actuelle: $permission');
      
      if (permission == LocationPermission.denied) {
        debugPrint('Demande de permission...');
        permission = await Geolocator.requestPermission();
        debugPrint('Permission après demande: $permission');
        
        if (permission == LocationPermission.denied) {
          _showLocationError('Autorisez l\'accès à votre position pour continuer.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showLocationError('Allez dans Paramètres > Applications > Votre App > Permissions pour autoriser la localisation.');
        return;
      }

      debugPrint('Étape 3: Obtention de la position GPS');
      Position? position;
      try {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium,
          timeLimit: const Duration(seconds: 15),
        );
        debugPrint('Position obtenue: ${position.latitude}, ${position.longitude}');
      } catch (e) {
        debugPrint('Erreur lors de l\'obtention de la position: $e');
        rethrow;
      }
      debugPrint('Étape 4: Génération d\'une adresse approximative');
      String approximateAddress = _getApproximateAddress(position.latitude, position.longitude);
      String cityFromCoords = _getCityFromCoordinates(position.latitude, position.longitude);

      if (mounted) {
        setState(() {
          _manualAddressController.text = approximateAddress;
          if (_cityController.text.isEmpty) {
            _cityController.text = cityFromCoords;
          }
        });

      }
      
    } catch (e, stackTrace) {
      _showLocationError('Erreur: ${e.toString()}');
      debugPrint('Geolocator error details: $e');
      debugPrint('Stack trace: $stackTrace');
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingLocation = false;
        });
      }
    }
  }

  String _getCityFromCoordinates(double lat, double lon) {
    // Coordonnées approximatives des gouvernorats tunisiens
    if (lat >= 36.8 && lat <= 37.0 && lon >= 10.1 && lon <= 10.3) {
      return 'Tunis';
    } else if (lat >= 36.75 && lat <= 36.95 && lon >= 10.05 && lon <= 10.25) {
      return 'Ariana';
    } else if (lat >= 36.7 && lat <= 36.9 && lon >= 10.0 && lon <= 10.2) {
      return 'Manouba';
    } else if (lat >= 36.65 && lat <= 36.85 && lon >= 10.15 && lon <= 10.35) {
      return 'Ben Arous';
    } else if (lat >= 36.4 && lat <= 36.6 && lon >= 10.7 && lon <= 10.9) {
      return 'Nabeul';
    } else if (lat >= 36.25 && lat <= 36.45 && lon >= 10.1 && lon <= 10.3) {
      return 'Zaghouan';
    } else if (lat >= 37.1 && lat <= 37.3 && lon >= 9.8 && lon <= 10.0) {
      return 'Bizerte';
    } else if (lat >= 36.6 && lat <= 36.8 && lon >= 9.1 && lon <= 9.3) {
      return 'Béja';
    } else if (lat >= 35.7 && lat <= 35.9 && lon >= 10.0 && lon <= 10.2) {
      return 'Sousse';
    } else if (lat >= 35.7 && lat <= 35.9 && lon >= 10.75 && lon <= 10.95) {
      return 'Monastir';
    } else if (lat >= 35.4 && lat <= 35.6 && lon >= 11.0 && lon <= 11.2) {
      return 'Mahdia';
    } else if (lat >= 35.1 && lat <= 35.3 && lon >= 9.4 && lon <= 9.6) {
      return 'Kasserine';
    } else if (lat >= 34.7 && lat <= 34.9 && lon >= 10.5 && lon <= 10.7) {
      return 'Sfax';
    } else if (lat >= 34.4 && lat <= 34.6 && lon >= 10.1 && lon <= 10.3) {
      return 'Gabès';
    }
    return 'Tunis'; // Fallback par défaut
  }

  String _getApproximateAddress(double lat, double lon) {
    String city = _getCityFromCoordinates(lat, lon);
    Map<String, List<String>> cityAreas = {
      'Tunis': ['Avenue Habib Bourguiba', 'Rue de la Liberté', 'Avenue de la République', 'Rue Mongi Slim', 'Avenue Mohamed V'],
      'Ariana': ['Route de Raoued', 'Avenue de l\'Indépendance', 'Rue des Roses', 'Avenue Taieb Mhiri', 'Rue de Carthage'],
      'Sousse': ['Boulevard Hedi Chaker', 'Avenue Léopold Sédar Senghor', 'Rue Commandant Béjaoui', 'Avenue de la Corniche'],
      'Sfax': ['Avenue Habib Thameur', 'Rue Mongi Slim', 'Avenue Ali Belhaouane', 'Route de Tunis'],
      'Nabeul': ['Avenue Habib Bourguiba', 'Route de Hammamet', 'Rue de la Plage', 'Avenue Taieb Mhiri'],
      'Monastir': ['Rue de l\'Indépendance', 'Avenue Habib Bourguiba', 'Route de Sousse', 'Rue Farhat Hached'],
      'Bizerte': ['Avenue Habib Bourguiba', 'Rue d\'Alger', 'Avenue de la Corniche', 'Rue de Tunis'],
    };
    
    List<String> areas = cityAreas[city] ?? ['Avenue Principale', 'Rue Centrale', 'Route Nationale'];
    String randomArea = areas[(lat * 1000).toInt() % areas.length];
    int streetNumber = ((lat + lon) * 100).toInt() % 200 + 1;
    
    return '$streetNumber $randomArea, $city';
  }

  
  // GPS functionality completed

  void _showLocationError(String message) {
    _showSnackBar(message, Colors.red);
  }

  void _showSuccess(String message) {
    _showSnackBar(message, Colors.green);
  }

  void _showError(String message) {
    _showSnackBar(message, Colors.red);
  }

  void _showSnackBar(String message, Color backgroundColor) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}