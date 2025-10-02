import 'package:flutter/material.dart';

class BadgePerformanceChart extends StatelessWidget {
  final List<PerformanceData> performanceData;

  const BadgePerformanceChart({
    Key? key,
    required this.performanceData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: 628,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade600,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête avec le titre et la légende
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Performance du badge',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2A2A4A),
                ),
              ),
              const Text(
                'Toutes informations en pourcentage (%)',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFA0A0A0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Disposition parallèle verticale - Liste des catégories et graphique côte à côte
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Liste des catégories avec leurs indicateurs de couleur
                Container(
                  width: 200, // Largeur fixe pour la liste des catégories
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: performanceData
                        .map((data) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: data.color,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2A2A4A),
                                          ),
                                        ),
                                        const Text(
                                          'Performance',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFFA0A0A0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),

                // Le graphique à barres 3D
                Expanded(
                  child: Container(
                    height: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Échelle de valeurs
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('100',
                                style: TextStyle(color: Color(0xFFA0A0A0))),
                            const Text('75',
                                style: TextStyle(color: Color(0xFFA0A0A0))),
                            const Text('55',
                                style: TextStyle(color: Color(0xFFA0A0A0))),
                            const Text('35',
                                style: TextStyle(color: Color(0xFFA0A0A0))),
                            const Text('00',
                                style: TextStyle(color: Color(0xFFA0A0A0))),
                          ],
                        ),

                        const SizedBox(width: 8),

                        // Zone du graphique
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(color: Colors.grey.shade300),
                                bottom: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: performanceData
                                  .map((data) => _buildBar3D(
                                        height: data.percentage * 2,
                                        color: data.color,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar3D({required double height, required Color color}) {
    // Couleur plus foncée pour le côté
    Color sideColor = HSLColor.fromColor(color)
        .withLightness(
            (HSLColor.fromColor(color).lightness - 0.1).clamp(0.0, 1.0))
        .toColor();

    // Couleur plus claire pour le dessus
    Color topColor = HSLColor.fromColor(color)
        .withLightness(
            (HSLColor.fromColor(color).lightness + 0.1).clamp(0.0, 1.0))
        .toColor();

    return Container(
      width: 60,
      height: height,
      child: Stack(
        children: [
          // Face principale
          Positioned.fill(
            child: Container(color: color),
          ),

          // Face supérieure (vue en perspective)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 10,
              child: CustomPaint(
                size: Size(60, 10),
                painter: TopFacePainter(topColor),
              ),
            ),
          ),

          // Face latérale (vue en perspective)
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: 10,
              child: CustomPaint(
                size: Size(10, height),
                painter: SideFacePainter(sideColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Les classes TopFacePainter, SideFacePainter et PerformanceData restent inchangées

// Peintre personnalisé pour la face supérieure
class TopFacePainter extends CustomPainter {
  final Color color;

  TopFacePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width - 10, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Peintre personnalisé pour la face latérale
class SideFacePainter extends CustomPainter {
  final Color color;

  SideFacePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 10)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Classe pour stocker les données de performance
class PerformanceData {
  final String title;
  final Color color;
  final double percentage;

  PerformanceData({
    required this.title,
    required this.color,
    required this.percentage,
  });
}
