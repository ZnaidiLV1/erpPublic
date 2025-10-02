import 'package:flutter/material.dart';

import '../children/components/add_children.dart';
import '../children/components/children_details.dart';
import '../children/components/update_children.dart';
import 'add_edit_annimatrice.dart';
import 'components/animatrice_body.dart';

class AnimatriceScreen extends StatefulWidget {
  const AnimatriceScreen({super.key});

  @override
  State<AnimatriceScreen> createState() => _AnimatriceScreen();
}

class _AnimatriceScreen extends State<AnimatriceScreen> {
  int index = 0;

  void _changeScreen(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:  IndexedStack(
      index: index,
      children: [
        AnimatriceBody(
          onAddPressed: () => _changeScreen(1),
          onItemPressed: () => _changeScreen(2),
        ),
        AddEditAnimatrice(),
        ChildrenDetails(onCancelPressed: () => _changeScreen(0)),
        const UpdateChildren(),
      ],
    ));
  }
}
