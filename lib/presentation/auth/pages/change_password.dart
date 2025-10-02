import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import 'login.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isVisibel = false;
  bool isVisibel2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(
            child: Column(
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
                                  "Retour",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextFormField(
                            obscureText: !isVisibel,
                            decoration: InputDecoration(
                              labelText: "Créer un mot de passe",
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
                                  (isVisibel)
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: 24,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isVisibel = !isVisibel;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          obscureText: !isVisibel2,
                          decoration: InputDecoration(
                            labelText: "Ressaisissez le mot de passe",
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
                                (isVisibel2)
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 24,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  isVisibel2 = !isVisibel2;
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>  const  Login(),
                                ),
                              );
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
                                    "Définir le mot de passe",
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
              child: Image.asset("assets/images/password2.png"),
            ),
          ),
        ],
      ),
    );
  }
}
