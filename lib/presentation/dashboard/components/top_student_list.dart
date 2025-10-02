import 'package:flutter/material.dart';
import '../../../core/components/name_avatar.dart';
import '../../../core/shared/entities/badge.dart';
class TopStudentsList extends StatelessWidget {
  const TopStudentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30,),
        const SizedBox(
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Top Meilleur enfant",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              SizedBox()
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 270,
          width: 250,
          child: ListView.builder(
            itemCount: badges.length,
            itemBuilder: (context, index) {
              StudentBadge badge = badges[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: studentCard(badge),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget studentCard(StudentBadge badge) {
    return Container(
      width: 213,
      height: 58,
      decoration: BoxDecoration(
        color: badge.getcolor(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NameAvatar(fullName: badge.fullName, size: 35,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                overflow: TextOverflow.ellipsis,
                badge.fullName,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                '${badge.points}/ 10',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ],
          ),
          (badge.getImage() != null)? Image.asset(badge.getImage()!):const SizedBox()
        ],
      ),
    );
  }

}
