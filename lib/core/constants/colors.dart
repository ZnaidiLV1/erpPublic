import 'dart:ui';

import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor, {double opacity = 1.0}) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // Default to full opacity
    }
    int color = int.parse(hexColor, radix: 16);

    // Apply the opacity (convert to alpha channel)
    int alpha = (opacity * 255).toInt();
    color = (color & 0x00FFFFFF) | (alpha << 24); // Combine with new alpha
    return color;
  }

  HexColor(final String hexColor, {double opacity = 1.0})
      : super(_getColorFromHex(hexColor, opacity: opacity));
}

/* --LIST OF COLORS -- */

const bPrimaryColor = Color.fromARGB(255, 38, 166, 154); // Primary
const bSecondaryColor = Color(0xFF70C4CF); // Secondary
const bGris10 = Color(0xFF374151); // Gris 10
const bGris09 = Color(0xFF4B5563); // Gris 09
const bBleuDark = Color(0xFF081735); // Bleu Dark
const bBleu11 = Color(0xFF2E263D); // Bleu 11
const bBlack05 = Color(0xFF1F242F); // Black 05
const bBlack06 = Color(0xFF1C2A3A); // Black 06

const bBlack = Color(0xFF000000); // Black
const bGris = Color(0xFF6C757D); // Gris
const bBleu08 = Color(0xFF252C58); // Bleu 08
const bGris02 = Color(0xFFA098AE); // Gris 02
const bBleu07 = Color(0xFF303972); // Bleu 07
const bWhite = Color(0xFFFFFFFF); // White
const bGris08 = Color(0xFF6B7387); // Gris 08
const bGris9 = Color(0xFFEBEBF9); // Gris 09
const bGreen = Color(0xFF1EBA62); // Green
const bBleu01 = Color(0xFF4D44B5); // Bleu 01
const bRed = Color(0xFFE41F1F); // Red
const bRed05 = Color(0xFFFD5353); // Red 05
const bRed10 = Color(0xFFFFEAEA); // Red 10
const bYellow = Color(0xFFFCC43E); // Yellow
