import 'package:flutter/material.dart';

import 'add_menu.dart';

class ApercuContineWidget extends StatelessWidget {
  const ApercuContineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 96.0),
          SizedBox(
            width: 1258,
            height: 39,
            child: Stack(
              children: [
                const Positioned(
                  left: 24,
                  top: 0,
                  child: Text(
                    'Aperçu menu de repas et collations',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 28,
                      color: Color(0xFF374151),
                    ),
                  ),
                ),
                Positioned(
                  left: 888.29,
                  top: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      // Action pour exporter
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xFF374151),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: const BorderSide(color: Color(0xFFF0F2F4)),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.cloud_download,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Exporter',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Color(0xFF4B5563),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 1028,
                  top: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: "Ajouter menu",
                        transitionDuration: const Duration(milliseconds: 300),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: Material(
                              color: Colors.white,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(
                                      1, 0), // Start from the right
                                  end:
                                      Offset.zero, // End at its normal position
                                ).animate(CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInOut,
                                )),
                                child: const AddMenuForm(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF70C4CF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.add,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Ajouter menu',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
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
