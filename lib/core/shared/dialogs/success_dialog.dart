import 'package:flutter/material.dart';

Future<void> showSuccessDialog(BuildContext context, String title) async {

  showDialog(context: context, builder: (BuildContext context){
    Future.delayed(const Duration(seconds: 2), () {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
    return AlertDialog(
      backgroundColor: Colors.transparent,
      title: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.green.withOpacity(0.5),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.done_outline, color: Colors.white, size: 30,),
              SizedBox(width: 15,),
              Text(title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
            ],
          ),
        ),
      ),
    );
  });
}