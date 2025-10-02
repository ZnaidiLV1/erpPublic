import 'package:flutter/material.dart';

class ExpensesFilterBarRev extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1122,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Filtres
          Row(
            children: [
              _buildDropdown(Icons.timeline, "Date"),
              const SizedBox(width: 8),
              _buildDropdown(Icons.credit_card, "Catégories de revenue",
                  width: 236),
            ],
          ),

          // Barre de recherche
          Container(
            width: 411,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFBFBFB),
              border: Border.all(color: const Color(0xFFF0F2F4)),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: Color(0xFF959BA4), size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText:
                          "Rechercher par date, catégories de revenue...",
                      hintStyle:
                          TextStyle(color: Color(0xFF959BA4), fontSize: 14),
                      border: InputBorder.none,
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

  Widget _buildDropdown(IconData icon, String text, {double width = 98}) {
    return Container(
      width: width,
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFF0F2F4)),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4B5563), size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Color(0xFF4B5563), fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.arrow_drop_down, color: Color(0xFF4B5563), size: 16),
        ],
      ),
    );
  }
}
