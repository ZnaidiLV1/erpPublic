import 'package:flutter/material.dart';
import '../children/components/children_details.dart';
import '../children/components/update_children.dart';
import 'components/ajouter_event.dart';
import 'components/events_body.dart';
class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreen();
}

class _DriverScreen extends State<DriverScreen> {
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
        EventsPage(
          onAddPressed: () => _changeScreen(1), 
        ),
        EventFormScreen(
         onCancelPressed: () {
  print("Retour au EventsPage !");
  _changeScreen(0);
}

        ),
        ChildrenDetails(onCancelPressed: () => _changeScreen(0)),
        const UpdateChildren(),
      ],
    );
  }
}
