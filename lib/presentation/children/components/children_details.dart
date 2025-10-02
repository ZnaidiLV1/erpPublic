import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constants/colors.dart';
import 'children_progress_data_table.dart';

class ChildrenDetails extends StatelessWidget {
  final VoidCallback onCancelPressed;

  const ChildrenDetails({super.key, required this.onCancelPressed});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: IconButton(
                  onPressed: onCancelPressed, icon: const Icon(Icons.close)),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: 141,
                child: Image.asset("assets/images/details_background.png",
                    fit: BoxFit.fill),
              ),
              Positioned(
                top: 80,
                left: 20,
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      border: Border.all(color: Colors.white, width: 8)),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/avatar_1.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 80,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Karen Hope",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: HexColor("#303972")),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Text(
            "3 ans",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: HexColor("#4CB6AC")),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                      color: HexColor("#70C4CF")
                    ),
                    child: const Icon(Iconsax.user, color: Colors.white,),
                  ),
                  const SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Parents:"
                        ,style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: HexColor("#A098AE")),
                      ),
                      Text(
                        "Justin Hope"
                        ,style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: HexColor("#303972")),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: HexColor("#70C4CF")
                    ),
                    child: const Icon(Iconsax.location, color: Colors.white,),
                  ),
                  const SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address:"
                        ,style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: HexColor("#A098AE")),
                      ),
                      Text(
                        "Sahloul, Sousse"
                        ,style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: HexColor("#303972")),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: HexColor("#70C4CF")
                    ),
                    child: const Icon(Iconsax.call, color: Colors.white,),
                  ),
                  const SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Téléphone:"
                        ,style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: HexColor("#A098AE")),
                      ),
                      Text(
                        "+12 345 6789 0"
                        ,style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: HexColor("#303972")),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: HexColor("#70C4CF")
                    ),
                    child: const Icon(Iconsax.home_2, color: Colors.white,),
                  ),
                  const SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Classe:"
                        ,style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: HexColor("#A098AE")),
                      ),
                      Text(
                        "Classe XI"
                        ,style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: HexColor("#303972")),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 20,),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Text(
            "Historique des fiches de progression",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: HexColor("#303972")),
          ),
        ),
        const ChildrenProgressDataTable()
      ],
    );
  }
}
