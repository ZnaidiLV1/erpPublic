import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class DeleteClass extends StatefulWidget {
  const DeleteClass({super.key});

  @override
  State<DeleteClass> createState() => _DeleteClassState();
}

class _DeleteClassState extends State<DeleteClass> {
  bool isVisibel = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      // Adjust width
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Supprimer un classe",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: HexColor("#374151"),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black54),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 30),
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
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Entrez votre email",
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Mot de passe",
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
                obscureText: !isVisibel,
                decoration: InputDecoration(
                  hintText: "Entrez votre mot de passe",
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      (isVisibel)
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 24,
                      color: Colors.black38,
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

            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Secondary Button (Outlined)
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(150, 48),
                    side: const BorderSide(color: Colors.black, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    "Annuler",
                    style: TextStyle(color: Colors.black),
                  ),
                ),

                // Primary Button (Filled)
                ElevatedButton(
                  onPressed: () {
                    // Handle form submission
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor("#E41F1F"),
                    minimumSize: const Size(150, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    "Supprimer",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )


          ],
        ),
      ),
    );
  }
}
