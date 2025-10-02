// search_filter_widget.dart
import 'package:flutter/material.dart';

class SearchFilterWidget extends StatelessWidget {
  const SearchFilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Row pour les filtres
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    _buildDropdown(
                      icon: Icons.access_time,
                      label: "Date",
                      width: 98,
                    ),
                    SizedBox(width: 16),
                    _buildDropdown(
                      icon: Icons.credit_card,
                      label: "Classe",
                      width: 112,
                    ),
                    SizedBox(width: 16),
                    _buildDropdown(
                      icon: Icons.person,
                      label: "Nom d'enfant",
                      width: 168,
                    ),
                    SizedBox(width: 16),
                    _buildDropdown(
                      icon: Icons.credit_card,
                      label: "Type de badge",
                      width: 170,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              // Barre de recherche
              Container(
                width: 400,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFFBFBFB),
                  border: Border.all(color: Color(0xFFF0F2F4)),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 20,
                      color: Color(0xFF959BA4),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText:
                              "Rechercher par date, classe, nom d'enfant...",
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF959BA4),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
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

  Widget _buildDropdown({
    required IconData icon,
    required String label,
    required double width,
  }) {
    return Container(
      width: width,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFF0F2F4)),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Color(0xFF4B5563),
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF4B5563),
            ),
          ),
          Spacer(),
          Icon(
            Icons.keyboard_arrow_down,
            size: 16,
            color: Color(0xFF4B5563),
          ),
        ],
      ),
    );
  }
}
