import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../widgets/filter_badge.dart';
import '../widgets/state_badge_comport.dart';

class BadgeComport extends StatelessWidget {
  final VoidCallback onCancelPressed;
  const BadgeComport({Key? key, required this.onCancelPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: IconButton(onPressed: onCancelPressed, icon: const Icon(Icons.close)),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              const SizedBox(
                height: 150,
                child: StatsWidget(),
              ),
              const SizedBox(height: 20),
              Text(
                "Aperçu les badges",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: bGris10,
                ),
              ),
              const SizedBox(height: 20),
              const SearchFilterWidget(),
              const SizedBox(height: 20),
              InvoiceTable(), // Ensure this is correctly placed
            ],
          ),
        ),
      ),
    );
  }
}

class InvoiceTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          buildTableHeader(),
          buildTableRow(
            id: '#4908',
            name: 'Jennifer Summers',
            badgeType: 'Comportement',
            date: '01 Fev 2025',
            percentage: '45%',
            avatarUrl: 'https://via.placeholder.com/34', // Placeholder URL
          ),
          buildTableRow(
            id: '#4906',
            name: 'Nicholas Tanner',
            badgeType: 'Participation',
            date: '10 Sep 2025',
            percentage: '65%',
            avatarUrl: 'https://via.placeholder.com/34', // Placeholder URL
          ),
          buildTableRow(
            id: '#4905',
            name: 'Crystal Mays',
            badgeType: 'Comportement',
            date: '30 Nov 2025',
            percentage: '45%',
            avatarUrl: 'https://via.placeholder.com/34', // Placeholder URL
          ),
          buildTableRow(
            id: '#4903',
            name: 'Megan Roberts',
            badgeType: 'Comportement',
            date: '12 Avr 2025',
            percentage: '80%',
            avatarUrl: 'https://via.placeholder.com/34', // Placeholder URL
          ),
          buildTableRow(
            id: '#4902',
            name: 'Joseph Oliver',
            badgeType: 'Comportement',
            date: '01 Aou 2025',
            percentage: '45%',
            avatarUrl: 'https://via.placeholder.com/34', // Placeholder URL
          ),
        ],
      ),
    );
  }

  Widget buildTableHeader() {
    return Container(
      height: 56,
      color: const Color(0xFFF6F7FB),
      child: Row(
        children: [
          buildHeaderCell('ID'),
          buildHeaderCell('ENFANT'),
          buildHeaderCell('TYPE DE BADGE'),
          buildHeaderCell('DATE'),
          buildHeaderCell('POURCENTAGE'),
          buildHeaderCell('ACTION'),
        ],
      ),
    );
  }

  Widget buildHeaderCell(String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(46, 38, 61, 0.9),
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }

  Widget buildTableRow({
    required String id,
    required String name,
    required String badgeType,
    required String date,
    required String percentage,
    required String avatarUrl,
  }) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(46, 38, 61, 0.12),
          ),
        ),
      ),
      child: Row(
        children: [
          buildCellWithCheckbox(id),
          buildCellWithAvatar(name, avatarUrl),
          buildCell(badgeType),
          buildCell(date),
          buildCell(percentage),
          buildActionCell(),
        ],
      ),
    );
  }

  Widget buildCellWithCheckbox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Checkbox(value: false, onChanged: (value) {}),
          Text(text),
        ],
      ),
    );
  }

  Widget buildCellWithAvatar(String name, String avatarUrl) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(avatarUrl),
              radius: 17,
            ),
            const SizedBox(width: 10),
            Text(name),
          ],
        ),
      ),
    );
  }

  Widget buildCell(String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            color: Color.fromRGBO(46, 38, 61, 0.7),
          ),
        ),
      ),
    );
  }

  Widget buildActionCell() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
