import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/components/summary_section_2.dart';
import '../../../core/constants/colors.dart';
import '../../../core/shared/entities/summaryItem.dart';

class DriverBody extends StatefulWidget {
  final VoidCallback onAddPressed;
  final VoidCallback onItemPressed;

  const DriverBody(
      {super.key, required this.onAddPressed, required this.onItemPressed});

  @override
  State<DriverBody> createState() => _DriverBodyState();
}

class _DriverBodyState extends State<DriverBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SummarySection2(
          items: [
            SummaryItem(
              label: 'Chauffeur',
              value: 150,
              icon: Iconsax.people,
              color: HexColor("#70C4CF"),
            ),
            SummaryItem(
              label: 'Véhicules',
              value: 4,
              icon: Iconsax.car,
              color: HexColor("#FB7D5B"),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50,
              width: 200,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Search here...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide:
                    BorderSide(color: HexColor("#70C4CF"), width: 2),
                  ),
                  prefixIcon: Icon(
                    Iconsax.search_normal,
                    color: HexColor("#4D44B5"),
                    size: 18,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: widget.onAddPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  HexColor("#70C4CF"),
                ),
                fixedSize: const MaterialStatePropertyAll(Size(180, 50)),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(width: 5),
                  Text("Ajouter Chauffeur",style: TextStyle(color: Colors.white, fontSize: 13),),
                ],
              ),
            ),
          ],
        ),
        buildDriverBody(),
      ],
    );
  }

  int getRowCount(context) {
    if (MediaQuery.of(context).size.width > 1600) {
      return 5;
    } else if (MediaQuery.of(context).size.width > 1350) {
      return 4;
    } else {
      return 3;
    }
  }

  Widget buildDriverBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getRowCount(context),
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: 1,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          return buildAnimatriceCard();
        },
      ),
    );
  }

  Widget buildAnimatriceCard() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        //border: Border.all(color: HexColor("#70C4CF"), width: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                const Spacer(),
                PopupMenuButton<String>(
                  icon: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: HexColor("#EBEBF9"),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Icon(Iconsax.more,
                            color: HexColor("#70C4CF"), size: 18),
                      )),
                  onSelected: (value) {
                    if (value == "edit") {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: "Ajouter classe",
                        transitionDuration: const Duration(milliseconds: 300),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: Material(
                              color: Colors.transparent,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  // Start from the right
                                  end: Offset.zero, // End at its normal position
                                ).animate(CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInOut,
                                )),
                                child: Container(),
                              ),
                            ),
                          );
                        },
                      );
                      print("Edit tapped");
                    } else if (value == "delete") {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: "Ajouter classe",
                        transitionDuration: const Duration(milliseconds: 300),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: Material(
                              color: Colors.transparent,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  // Start from the right
                                  end: Offset.zero, // End at its normal position
                                ).animate(CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInOut,
                                )),
                                child: Container(),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: "edit",
                      child: Row(
                        children: [
                          Icon(Icons.edit_outlined, size: 16, color: Colors.blue),
                          SizedBox(width: 10),
                          Text("Edit"),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: "delete",
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline, size: 16, color: Colors.red),
                          SizedBox(width: 10),
                          Text("Delete"),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.asset(
                  "assets/images/avatar_1.png",
                  height: 80,
                  width: 80,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 1,
                left: 1,
                child: Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: HexColor("#1EBA62"),
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Dimitres Viga",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: HexColor("#303972")),
          ),
          Text(
            "Sahloul",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: HexColor("#A098AE")),
          ),
          const SizedBox(height: 5,),
          Container(
            decoration: BoxDecoration(
              color: HexColor("#DDFAEA"),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                "Minibus scolaire",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: HexColor("#1EBA62")),
              ),
            ),
          ),
          const SizedBox(height: 18,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("#70C4CF"),
                  minimumSize: const Size(120, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.person, size: 13, color: Colors.white,),
                    SizedBox(width: 10,),
                    Text(
                      "Profile",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 15,),
              ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("#EBEBF9"),
                  minimumSize: const Size(120, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.email_outlined, size: 13, color: Colors.black,),
                    SizedBox(width: 10,),
                    Text(
                      "Chat",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
