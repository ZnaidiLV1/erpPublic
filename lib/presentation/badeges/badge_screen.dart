
import 'package:flutter/material.dart';

import 'components/badge_comport.dart';
import 'components/badges_body.dart';


class BadgeScreen extends StatefulWidget {
  const BadgeScreen({super.key});

  @override
  State<BadgeScreen> createState() => _AnimatriceScreen();
}

class _AnimatriceScreen extends State<BadgeScreen> {
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
      children:  [
        BadgesBody(
          onItemPressed: () => _changeScreen(1),
        ),
         BadgeComport(onCancelPressed: () => _changeScreen(0)),
        // AddChildren(onCancelPressed: () => _changeScreen(0)),
        // ChildrenDetails(onCancelPressed: () => _changeScreen(0)),
        // const UpdateChildren(),
      ],
    );
  }
}
