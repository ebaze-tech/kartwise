import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart  ';

class FontSize {
  static const small = 14.0;
  static const standard = 16.0;
  static const standardUp = 18.0;
  static const medium = 20.0;
  static const large = 28.0;
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
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: DefaultColors.primary,
      scaffoldBackgroundColor: DefaultColors.whiteText,
      textTheme: TextTheme(
        titleMedium: GoogleFonts.poppins(
          fontSize: FontSize.standard,
          color: DefaultColors.darkText,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: FontSize.large,
          color: DefaultColors.darkText,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: FontSize.small,
          color: DefaultColors.darkText,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: FontSize.standardUp,
          color: DefaultColors.darkText,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: FontSize.large,
          color: DefaultColors.darkText,
        ),
      ),
    );
  }
}
