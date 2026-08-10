import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart  ';

class FontSize {
  // Display
  static const displayLarge = 32.0;
  static const displayMedium = 28.0;
  static const displaySmall = 24.0;

  // Headings
  static const headingLarge = 24.0;
  static const headingMedium = 20.0;
  static const headingSmall = 18.0;

  // Body
  static const bodyLarge = 16.0;
  static const bodyMedium = 14.0;
  static const bodySmall = 13.0;

  // UI
  static const labelLarge = 14.0;
  static const labelMedium = 12.0;
  static const labelSmall = 11.0;

  // Special
  static const caption = 12.0;
}

class DefaultColors {
  static const Color primary = Color(0xFF059669);
  static const Color secondary = Color(0xFF1E3A8A);
  static const Color tertiary = Color(0xFFF97316);
  static const Color neutral = Color(0xFF111827);
  static const Color danger = Color(0xFFDC2626);
  static const Color warning = Color(0xFFFBBF24);
  static const Color success = Color(0xFF16A34A);
  static const Color background = Color(0xFFF3F4F6);
  static const Color whiteText = Color(0xFFFFFFFF);
  static const Color darkText = Color(0xFF111827);
  static const Color gray = Color(0xFF6B7280);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: DefaultColors.primary,
      scaffoldBackgroundColor: DefaultColors.whiteText,

      textTheme: TextTheme(
        // Large page titles
        displayLarge: GoogleFonts.poppins(
          fontSize: FontSize.displayLarge,
          fontWeight: FontWeight.bold,
          color: DefaultColors.darkText,
        ),

        displaySmall: GoogleFonts.poppins(
          fontSize: FontSize.displaySmall,
          fontWeight: FontWeight.bold,
          color: DefaultColors.darkText,
        ),

        // Section/page headings
        titleLarge: GoogleFonts.poppins(
          fontSize: FontSize.headingLarge,
          fontWeight: FontWeight.bold,
          color: DefaultColors.darkText,
        ),

        titleMedium: GoogleFonts.poppins(
          fontSize: FontSize.headingMedium,
          fontWeight: FontWeight.w600,
          color: DefaultColors.darkText,
        ),

        titleSmall: GoogleFonts.poppins(
          fontSize: FontSize.headingSmall,
          fontWeight: FontWeight.w600,
          color: DefaultColors.darkText,
        ),

        // Body text
        bodyLarge: GoogleFonts.poppins(
          fontSize: FontSize.bodyLarge,
          fontWeight: FontWeight.w400,
          color: DefaultColors.darkText,
        ),

        bodyMedium: GoogleFonts.poppins(
          fontSize: FontSize.bodyMedium,
          fontWeight: FontWeight.w400,
          color: DefaultColors.darkText,
        ),

        bodySmall: GoogleFonts.poppins(
          fontSize: FontSize.bodySmall,
          fontWeight: FontWeight.w400,
          color: DefaultColors.darkText,
        ),
      ),
    );
  }
}
