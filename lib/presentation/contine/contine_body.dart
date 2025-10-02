import 'package:biboo_pro/presentation/contine/widgets/aprecu_contine.dart';
import 'package:biboo_pro/presentation/contine/widgets/card_contine.dart';
import 'package:flutter/material.dart';

class DatePickerInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: 239,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFA098AE)),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Choisir date',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.4,
                  color: Color(0xFF6C757D),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Icon(
                Icons.calendar_today,
                color: Color(0xFF6C757D),
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Contine extends StatefulWidget {
  const Contine({super.key});

  @override
  State<Contine> createState() => _ContineState();
}

class _ContineState extends State<Contine> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to the start
          children: [
            const ApercuContineWidget(),
            const SizedBox(height: 20),
            DatePickerInput(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 9, // Change this to the actual number of items
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Wrap(
                      spacing: 16.0,
                      runSpacing: 16.0,
                      children: List.generate(3, (innerIndex) => const MealCard()),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
    );
  }
}
