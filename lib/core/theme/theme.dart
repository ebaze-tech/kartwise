import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  // Core Palette
  static const Color primary = Color(0xFF059669);
  static const Color secondary = Color(0xFF1E3A8A);
  static const Color tertiary = Color(0xFFF97316);
  static const Color neutral = Color(0xFF111827);

  // UI Backgrounds & Surfaces
  static const Color background = Color(
    0xFFF9FAFB,
  ); // Light gray app background
  static const Color surface = Color(
    0xFFFFFFFF,
  ); // Pure white for cards/components

  // States
  static const Color error = Color(0xFFDC2626);
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFFBBF24);

  // Text & Utilities
  static const Color whiteText = Color(0xFFFFFFFF);
  static const Color darkText = Color(0xFF111827);
  static const Color gray = Color(0xFF6B7280);
  static const Color lightGray = Color(0xFFE5E7EB);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: DefaultColors.primary,
      scaffoldBackgroundColor: DefaultColors.background,

      // Modern Flutter relies heavily on ColorScheme
      colorScheme: const ColorScheme.light(
        primary: DefaultColors.primary,
        secondary: DefaultColors.secondary,
        tertiary: DefaultColors.tertiary,
        error: DefaultColors.error,
        surface: DefaultColors.surface,
        onPrimary: DefaultColors.whiteText,
        onSecondary: DefaultColors.whiteText,
        onSurface: DefaultColors.darkText,
      ),

      // Typography (Using Inter to match the design file)
      textTheme: TextTheme(
        // Display titles
        displayLarge: GoogleFonts.inter(
          fontSize: FontSize.displayLarge,
          fontWeight: FontWeight.bold,
          color: DefaultColors.darkText,
        ),
        displayMedium: GoogleFonts.inter(
          fontSize: FontSize.displayMedium,
          fontWeight: FontWeight.bold,
          color: DefaultColors.darkText,
        ),
        displaySmall: GoogleFonts.inter(
          fontSize: FontSize.displaySmall,
          fontWeight: FontWeight.bold,
          color: DefaultColors.darkText,
        ),

        // Section/page headings
        titleLarge: GoogleFonts.inter(
          fontSize: FontSize.headingLarge,
          fontWeight: FontWeight.bold,
          color: DefaultColors.darkText,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: FontSize.headingMedium,
          fontWeight: FontWeight.w600,
          color: DefaultColors.darkText,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: FontSize.headingSmall,
          fontWeight: FontWeight.w600,
          color: DefaultColors.darkText,
        ),

        // Body text
        bodyLarge: GoogleFonts.inter(
          fontSize: FontSize.bodyLarge,
          fontWeight: FontWeight.w400,
          color: DefaultColors.darkText,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: FontSize.bodyMedium,
          fontWeight: FontWeight.w400,
          color: DefaultColors.darkText,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: FontSize.bodySmall,
          fontWeight: FontWeight.w400,
          color: DefaultColors.darkText,
        ),

        // Labels
        labelLarge: GoogleFonts.inter(
          fontSize: FontSize.labelLarge,
          fontWeight: FontWeight.w500,
          color: DefaultColors.darkText,
        ),
      ),

      // --- Component Themes ---

      // 1. Buttons & CTAs
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DefaultColors.primary,
          foregroundColor: DefaultColors.whiteText,
          disabledBackgroundColor: DefaultColors.primary.withValues(alpha:0.4),
          disabledForegroundColor: DefaultColors.whiteText.withValues(alpha:0.8),
          textStyle: GoogleFonts.inter(
            fontSize: FontSize.bodyLarge,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 0,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: DefaultColors.secondary,
          side: const BorderSide(color: DefaultColors.secondary, width: 1.5),
          backgroundColor: const Color(0xFFEFF6FF), // Soft secondary fill
          textStyle: GoogleFonts.inter(
            fontSize: FontSize.bodyLarge,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),

      // 2. Product Cards
      cardTheme: CardThemeData(
        color: DefaultColors.surface,
        elevation: 2,
        shadowColor: DefaultColors.neutral.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.zero,
      ),

      // 3. Search Bars & Input Fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DefaultColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 14.0,
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: FontSize.bodyMedium,
          color: DefaultColors.gray,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: DefaultColors.lightGray,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: DefaultColors.primary,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: DefaultColors.error, width: 1.0),
        ),
      ),

      // 4. Navigation & Tab Bars
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: DefaultColors.surface,
        selectedItemColor: DefaultColors.primary,
        unselectedItemColor: DefaultColors.gray,
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: FontSize.labelMedium,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: FontSize.labelMedium,
          fontWeight: FontWeight.w400,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
