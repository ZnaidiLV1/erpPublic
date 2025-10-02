import 'package:flutter/material.dart';

class ProgressionWidget extends StatelessWidget {
  const ProgressionWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500, // Fixed width that fits most screens
      height: 180,
      child: Stack(
        clipBehavior: Clip.none, // Prevents overflow clipping
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFC940),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.stacked_line_chart,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Fiches de progression totale',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF9A9CB8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '55',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFF2D3058),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '+23% ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF5DC5D5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'que le mois dernier',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF9A9CB8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 5,
            right: 60,
            child: SizedBox(
              width: 280,
              height: 100,
              child: Image.asset(
                'assets/images/chart_progress.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
