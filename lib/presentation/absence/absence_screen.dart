import 'package:flutter/material.dart';

import 'components/absenceBody.dart';
import 'components/absence_details.dart';

class AbsenceScreen extends StatefulWidget {
  const AbsenceScreen({super.key});

  @override
  State<AbsenceScreen> createState() => _AbsenceScreenState();
}

class _AbsenceScreenState extends State<AbsenceScreen> {

  int index = 0;

  void _changeScreen(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }
  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: [
        AbsenceBody(
            onAddPressed: () => _changeScreen(1),
            onItemPressed: () => _changeScreen(1)),
         AbsenceDetails(onCancelPressed: () => _changeScreen(0)),
      ],
    );
  }
}
