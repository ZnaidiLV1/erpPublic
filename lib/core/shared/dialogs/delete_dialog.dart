
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

Future<void> showDeleteDialog(BuildContext context, String title, Function onTap) async {
   showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: HexColor("#4A3AFF").withOpacity(0.1),
                ),
                child: Image.asset('assets/images/delete_icon.png'),
              ),
              const SizedBox(height: 30,),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 34,
                    color: HexColor("#303972")),
              ),
              const SizedBox(height: 30,),
              SizedBox(
                width: 500,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Entrez votre email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      gapPadding: 10
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: 500,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Entrez votre mot de passe",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          gapPadding: 10
                      ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: HexColor("#70C4CF"), width: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed:  (){
              Navigator.of(context).pop();
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(150, 48),
              side: BorderSide(color: HexColor("#A098AE"), width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text(
              "Annuler",
              style: TextStyle(color: HexColor("#A098AE")),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child:  Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                onPressed: () async {
                  await onTap();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("#FD5353"),
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
            ),
          ),
        ],
      );
    },
  );
}
