import 'package:flutter/material.dart';

import 'components/add_children.dart';
import 'components/children_body.dart';
import 'components/children_details.dart';
import 'components/update_children.dart';

class ChildrenScreen extends StatefulWidget {
  const ChildrenScreen({super.key});

  @override
  State<ChildrenScreen> createState() => _ChildrenScreenState();
}

class _ChildrenScreenState extends State<ChildrenScreen> {
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
        ChildrenBody(
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
