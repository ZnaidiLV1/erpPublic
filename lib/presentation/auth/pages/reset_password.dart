import 'package:biboo_pro/presentation/auth/pages/verify_code.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import 'change_password.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: Image.asset('assets/images/logo_small.png'),
                ),

                Center(
                  child: SizedBox(
                    width: 480,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 24,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Retour à la connexion",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Text(
                          "Mot de passe oublié ?",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 40),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Ne vous inquiétez pas, cela arrive à tout le monde. Entrez votre e-mail ci-dessous pour récupérer votre mot de passe.",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: HexColor("#313131")),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextFormField(
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
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>  VerifyCode(isSignUp: false,)));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                HexColor("#515DEF").withOpacity(0.6)),
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
                                child: Text(
                                  "Envoyer",
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(50),
              child: Image.asset("assets/images/password.png"),
            ),
          ),
        ],
      ),
    );
  }
}
