import 'package:biboo_pro/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'change_password.dart';
import 'login.dart';

class VerifyCode extends StatefulWidget {
  final String? email;
  final bool isSignUp;

  const VerifyCode({super.key, this.email,
    required this.isSignUp});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController(text: '');
  bool _obscure = false;
  bool _resending = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  String? _validateCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Veuillez saisir le code';
    }
    if (value.trim().length < 6) {
      return 'Le code doit contenir au moins 6 caractères';
    }
    return null;
  }

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
                    width: 520,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
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
                            'Vérifier le code',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Un code d'authentification a été envoyé à votre e-mail.",
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: HexColor('#313131')),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _codeController,
                            validator: _validateCode,
                            obscureText: _obscure,
                            decoration: InputDecoration(
                              labelText: 'Saisissez le code',
                              hintText: 'XXXXXX',
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
                                icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.black),
                                onPressed: () => setState(() => _obscure = !_obscure),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text("Vous n'avez pas reçu de code ? "),
                              InkWell(
                                onTap: _resending
                                    ? null
                                    : () async {
                                        setState(() => _resending = true);
                                        await Future<void>.delayed(const Duration(seconds: 1));
                                        if (!mounted) return;
                                        setState(() => _resending = false);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Code renvoyé'), backgroundColor: Colors.black87),
                                        );
                                      },
                                child: Text(
                                  'Renvoyer',
                                  style: TextStyle(color: HexColor('#FF8682')),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() == true) {

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Code vérifié avec succès'), backgroundColor: Colors.green),
                                );
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>  widget.isSignUp? const   Login():  const ChangePassword(),
                                  ),
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(HexColor('#7A83F3')),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              ),
                            ),
                            child: const SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: Center(child: Text('Vérifier', style: TextStyle(color: Colors.white))),
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
              child: Image.asset('assets/images/password2.png'),
            ),
          ),
        ],
      ),
    );
  }
}


