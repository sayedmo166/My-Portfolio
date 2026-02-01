import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.primaryBackground,
      primaryColor: AppColors.primaryAccent,

      // Typography
      textTheme: GoogleFonts.outfitTextTheme(
        ThemeData.dark().textTheme,
      ).copyWith(
        displayLarge: TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(color: AppColors.secondaryText),
        bodyMedium: TextStyle(color: AppColors.secondaryText),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: AppColors.secondaryBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: AppColors.primaryText),
    );
  }
}
