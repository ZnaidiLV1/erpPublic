
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../core/components/summary_section.dart';
import '../../core/constants/colors.dart';
import '../../core/shared/entities/summaryItem.dart';
import 'components/add_class.dart';
import 'components/delete_class.dart';
import 'components/edit_class.dart';

class ClassRoomScreen extends StatefulWidget {
  const ClassRoomScreen({super.key});

  @override
  State<ClassRoomScreen> createState() => _ClassRoomScreenState();
}

class _ClassRoomScreenState extends State<ClassRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummarySection(
          items: [
            SummaryItem(
                label: 'Enfants',
                value: 150,
                icon: Iconsax.people,
                color: HexColor("#70C4CF")),
            SummaryItem(
                label: 'Animatrice',
                value: 25,
                icon: Iconsax.task_square,
                color: HexColor("#FB7D5B")),
            SummaryItem(
                label: 'Classe',
                value: 10,
                icon: Iconsax.house,
                color: HexColor("#56CA00")),
            SummaryItem(
                label: 'Équipements',
                value: 50,
                icon: Iconsax.setting_4,
                color: HexColor("#E41F1F")),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Aperçu les classes",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                  color: HexColor("#374151")),
            ),
            ElevatedButton(
              onPressed: () {
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
                            begin: const Offset(1, 0), // Start from the right
                            end: Offset.zero, // End at its normal position
                          ).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeInOut,
                          )),
                          child: const AddClass(),
                        ),
                      ),
                    );
                  },
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  HexColor("#70C4CF"),
                ),
                fixedSize: const MaterialStatePropertyAll(Size(160, 36)),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                )),

              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(width: 5),
                  Text("Ajouter classe",style: TextStyle(color: Colors.white, fontSize: 13),),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: DefaultTabController(
            length: 5,
            child: Column(
              children: [
                Row(
                  children: [
                    TabBar(
                      tabs: const [
                        Tab(text: 'Tous les classes'),
                        Tab(text: "Classe XI"),
                        Tab(text: "Classe XI"),
                        Tab(text: "Classe XI"),
                        Tab(text: "Classe XI"),
                      ],
                      labelColor: HexColor("#70C4CF"),
                      unselectedLabelColor: bGris10,
                      indicatorColor: HexColor("#70C4CF"),
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                    ),
                    const Spacer()
                  ],
                ),
                const Divider(),
                Expanded(
                  child: TabBarView(
                    children: [
                      Center(child: classBody()),
                      const Center(child: Text("2")),
                      const Center(child: Text("3")),
                      const Center(child: Text("4")),
                      const Center(child: Text("5")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  int getRowCount(context) {
    if (MediaQuery.of(context).size.width > 1368) {
      return 5;
    } else if (MediaQuery.of(context).size.width > 1160) {
      return 4;
    } else {
      return 3;
    }
  }

  Widget classBody(){
    final List<Color> colors = [
      HexColor("#FF942E"),
      HexColor("#DF3670"),
      HexColor("#096C86"),
      HexColor("#4F3FF0"),
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getRowCount(context),
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: 1.01,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          return buildClassCard(colors[index % colors.length]);
        },
      ),
    );
  }

  Widget buildClassCard(Color color) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "December 20, 2021",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: HexColor("#6F6F6F"),
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Iconsax.more, size: 20),
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
                                begin:
                                    const Offset(1, 0), // Start from the right
                                end: Offset.zero, // End at its normal position
                              ).animate(CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              )),
                              child: const EditClass(),
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
                                begin:
                                    const Offset(1, 0), // Start from the right
                                end: Offset.zero, // End at its normal position
                              ).animate(CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              )),
                              child: const DeleteClass(),
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
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            overflow: TextOverflow.ellipsis,
            "Classe XIV",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: HexColor("#000000"),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "2-3 Ans",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: HexColor("#6F6F6F"),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                "Nombre d'enfant",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: HexColor("#242424"),
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: 0.8,
                  color: color,
                  backgroundColor: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  minHeight: 6,
                ),
              ),
              const SizedBox(width: 5),
              const Text("15", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 16, color: color),
                ),
                const SizedBox(width: 10),
                Text(
                  overflow: TextOverflow.ellipsis,
                  "Mohamed Mbarek",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
