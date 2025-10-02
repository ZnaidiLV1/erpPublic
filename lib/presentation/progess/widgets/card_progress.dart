import 'package:biboo_pro/presentation/progess/widgets/progress_detailes.dart';
import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Naviguer vers ProgressSheet lorsque la carte est cliquée
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: "Ajouter classe",
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) {
            return Align(
              alignment: Alignment.centerRight,
              child: Material(
                color: Colors.white,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0), // Start from the right
                    end: Offset.zero, // End at its normal position
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  )),
                  child: ProgressDetails(),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        width: 300,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0), // Ajoute un espace intérieur
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.calendar_today, color: Colors.white),
                  Text('23 Mar 2024', style: TextStyle(color: Colors.white)),
                  Icon(Icons.access_time, color: Colors.white),
                  Text('12:45 pm', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Nesrine Dziri',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Marwa Jbarra'),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'Classe VIA',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Stack(
              children: [
                Container(
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                Container(
                  height: 8.0,
                  width: 220.0, // 77% of 285
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text('77%'),
            SizedBox(height: 8.0),
            const Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                Text(
                  'Terminé',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
