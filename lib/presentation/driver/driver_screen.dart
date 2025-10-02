import 'package:flutter/material.dart';

import '../children/components/add_children.dart';
import '../children/components/children_details.dart';
import '../children/components/update_children.dart';
import 'components/driver_body.dart';


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
        DriverBody(
          onAddPressed: () => _changeScreen(1),
          onItemPressed: () => _changeScreen(2),
        ),
        AddChildren(onCancelPressed: () {  },),
        ChildrenDetails(onCancelPressed: () => _changeScreen(0)),
        const UpdateChildren(),
      ],
    );
  }
}
