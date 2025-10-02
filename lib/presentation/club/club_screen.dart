import 'package:flutter/material.dart';

import 'components/add_club.dart';
import 'components/club_body.dart';

class ClubScreen extends StatefulWidget {
  const ClubScreen({super.key});

  @override
  State<ClubScreen> createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  int index = 0;

  void _changeScreen(int newIndex) {
    print(index);
    setState(() {
      index = newIndex;
    });
  }
  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: [
        ClubsBody(
          onAddPressed: () => _changeScreen(1),
          onItemPressed: () => _changeScreen(2),
        ),
        AddClub(onCancelPressed: () => _changeScreen(0)),
        // AddChildren(onCancelPressed: () => _changeScreen(0)),
        // ChildrenDetails(onCancelPressed: () => _changeScreen(0)),
        // const UpdateChildren(),
      ],
    );
  }
}
