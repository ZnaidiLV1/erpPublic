import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/components/summary_section_2.dart';
import '../../../core/shared/entities/summaryItem.dart';
import 'absence_pie_chart.dart';
import 'add_children_absence.dart';
import '../../../core/constants/colors.dart';

class AbsenceBody extends StatefulWidget {
  final VoidCallback onAddPressed;
  final VoidCallback onItemPressed;

  const AbsenceBody(
      {super.key, required this.onAddPressed, required this.onItemPressed});

  @override
  State<AbsenceBody> createState() => _AbsenceBodyState();
}

class _AbsenceBodyState extends State<AbsenceBody> {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Column(
      children: [
        SummarySection2(
          items: [
            SummaryItem(
              label: 'Enfants',
              value: 80,
              icon: Iconsax.people,
              color: HexColor("#70C4CF"),
            ),
            SummaryItem(
              label: 'Absent',
              value: 2,
              icon: Iconsax.task_square,
              color: HexColor("#FB7D5B"),
            ),
          ],
        ),
        Expanded(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Row(
                  children: [
                    TabBar(
                      tabs: const [
                        Tab(text: 'Enfants'),
                        Tab(text: "Animatrice"),
                        Tab(text: "Chauffeur"),
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
                      Center(child: buildAbsenceBody()),
                      const Center(child: Text("2")),
                      const Center(child: Text("3")),
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
    if (MediaQuery.of(context).size.width > 1460) {
      return 4;
    } else if (MediaQuery.of(context).size.width > 1160) {
      return 3;
    } else {
      return 2;
    }
  }

  Widget buildAbsenceBody() {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Aperçu des absences",
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
                  barrierLabel: "+ Ajouter Absence",
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
                          child: const AddChildrenAbsence(),
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
                fixedSize: const MaterialStatePropertyAll(Size(170, 36)),
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
                  Text("Ajouter Absence", style: TextStyle(color: Colors.white, fontSize: 13),),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 30,),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: getRowCount(context),
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            childAspectRatio: 1.01,
          ),
          itemCount: 12,
          itemBuilder: (context, index) {
            return buildAbsenceCard(30);
          },
        ),
      ],
    );
  }

  Widget buildAbsenceCard(int value) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: HexColor("#D5E0F6"), width: 1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Container(
              height: 110,
              decoration: BoxDecoration(
                color: HexColor("#E7E6E3"),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          border: Border.all(color: Colors.white, width: 3)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.asset(
                          "assets/images/avatar_1.png",
                          height: 75,
                          width: 75,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Nesrine Dziri",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor("#081735")),
                        ),
                        Text(
                          "Classe XIV",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: HexColor("#4B5563")),
                        ),

                        Row(
                          children: [
                            const Icon(Iconsax.location, size: 15,),
                            const SizedBox(width: 3,),
                            Text(
                              "Sousse",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: HexColor("#4B5563")),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            widget.onItemPressed();
                          },
                          icon: Icon(Icons.arrow_circle_right, size: 30, color: HexColor("#41394E"),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Marwa Jbarra",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: HexColor("#1F242F")),
                      ),
                      Text(
                        "parent",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: HexColor("#6B7387")),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        "07",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: HexColor("#1F242F")),
                      ),
                      Text(
                        "Nombre d’absence",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: HexColor("#6B7387")),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: AbsencePieChart(value: 20,),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
