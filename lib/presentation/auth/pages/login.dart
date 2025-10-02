import 'package:biboo_pro/core/constants/colors.dart';
import 'package:biboo_pro/presentation/auth/pages/register.dart';
import 'package:biboo_pro/presentation/auth/pages/reset_password.dart';
import 'package:flutter/material.dart';
import '../../../core/main_screen/main_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _keepConnected = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Veuillez entrer un email valide';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre mot de passe';
    }
    if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    //final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("assets/images/logo_small.png"),
                ),
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: 480,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Connexion",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 40),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Connectez-vous pour accéder à votre compte BiBoo.",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: HexColor("#313131")),
                            ),
                          ),
                          //
                          // // Error message
                          // if (authProvider.errorMessage != null)
                          //   Padding(
                          //     padding: const EdgeInsets.only(bottom: 10),
                          //     child: Text(
                          //       authProvider.errorMessage!,
                          //       style: TextStyle(
                          //         color: Colors.red,
                          //         fontSize: 14,
                          //       ),
                          //     ),
                          //   ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: TextFormField(
                              controller: _emailController,
                              validator: _validateEmail,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (_) =>  null,
                              decoration: InputDecoration(
                                labelText: "Email ou numéro de téléphone",
                                hintText: "biboo@gmail.com ou 22 222 222",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(width: 1),
                                ),
                                labelStyle: const TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(width: 1),
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            validator: _validatePassword,
                            obscureText: !_isPasswordVisible,
                            onChanged: (_) => null,
                            decoration: InputDecoration(
                              labelText: "Mot de passe",
                              hintText: "*******************",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(width: 1),
                              ),
                              labelStyle: const TextStyle(color: Colors.black),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(width: 1),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: 24,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      activeColor: HexColor("#515DEF"),
                                      value: _keepConnected,
                                      onChanged: (val) {
                                        setState(() {
                                          _keepConnected = val!;
                                        });
                                      },
                                    ),
                                    const Text(
                                      "Rester connecté",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const ResetPassword(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Mot de passe oublié",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: HexColor("#FF8682")),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: false
                                ? null
                                : () async {
                              if (_formKey.currentState!.validate()) {
                                // final user = await authProvider.loginWithEmailAndPassword(
                                //   _emailController.text.trim(),
                                //   _passwordController.text.trim(),
                                // );

                               // if (user != null) {
                               // Navigate to home screen
                                Navigator.pushReplacement(context,
                                     MaterialPageRoute(builder: (context) => MainScreen()));

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Connexion réussie! Bienvenue'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                            //  }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return HexColor("#515DEF").withOpacity(0.3);
                                  }
                                  return HexColor("#515DEF");
                                },
                              ),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: Center(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 8),
                             child:
      // authProvider.isLoading
                                  //     ? const CircularProgressIndicator(
                                  //   valueColor:
                                  //   AlwaysStoppedAnimation<Color>(
                                  //       Colors.white),
                                  // )
                                  //     :
                              Text(
                                    "Connexion",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: HexColor("#F3F3F3"),
                                    ),
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
                                const Text("Vous n'avez pas de compte ? "),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Register(),
                                    ),
                                  ),
                                  child: const Text('Inscivez-vous', style: TextStyle(color: Colors.pinkAccent)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(50),
              child: Image.asset("assets/images/login.png"),
            ),
          ),
        ],
      ),
    );
  }
}