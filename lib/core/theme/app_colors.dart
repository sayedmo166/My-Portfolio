import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const Color primaryBackground = Color(
    0xFF0A0A0A,
  ); // Very dark, almost black
  static const Color secondaryBackground = Color(
    0xFF161616,
  ); // Slightly lighter for cards

  // Accents
  static const Color primaryAccent = Color(0xFF00E5FF); // Cyan
  static const Color secondaryAccent = Color(0xFFBD00FF); // Purple

  // Text
  static const Color primaryText = Color(0xFFF5F5F5);
  static const Color secondaryText = Color(0xFFAAAAAA);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryAccent, secondaryAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [Color(0x1FFFFFFF), Color(0x0AFFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
