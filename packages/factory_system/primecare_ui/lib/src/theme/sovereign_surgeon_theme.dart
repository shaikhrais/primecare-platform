// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:primecare_ui/src/theme/theme_tokens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Sovereign Surgeon Design System
/// Implements "Depth-First" surfacing, Manrope/Inter typography, and 16dp corners.
/// Strictly adheres to the "No-Line" philosophy (no 1px borders).
class SovereignSurgeonTheme {
  // Brand Colors for Sovereign Surgeon (Obsidian & Precision Blue)
  static const Color obsidianBase = Color(0xFF020617);
  static const Color precisionBlue = Color(0xFF3B82F6);
  static const Color auraGold = Color(0xFFFFD700);
  
  static const Color surfaceGlass = Color(0xCCFFFFFF); // 80% white
  static const Color surfaceGlassDark = Color(0xCC0F172A); // 80% slate 900

  static TextTheme _buildTextTheme(Color baseColor, Color mutedColor) {
    return TextTheme(
      headlineLarge: GoogleFonts.manrope(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.0,
        color: baseColor,
      ),
      headlineMedium: GoogleFonts.manrope(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: baseColor,
      ),
      titleLarge: GoogleFonts.manrope(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: baseColor,
      ),
      titleMedium: GoogleFonts.manrope(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        color: baseColor,
        letterSpacing: 0.2,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        color: mutedColor,
        letterSpacing: 0.1,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: baseColor,
        letterSpacing: 1.2,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF1F5F9), // Slate 100
      primaryColor: precisionBlue,
      colorScheme: const ColorScheme.light(
        primary: precisionBlue,
        secondary: PrimeCareColors.purple,
        surface: Colors.white,
        onSurface: PrimeCareColors.radarDark,
        error: PrimeCareColors.rose,
      ),
      textTheme: _buildTextTheme(
        PrimeCareColors.radarDark,
        PrimeCareColors.slate500,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: PrimeCareColors.radarDark),
        titleTextStyle: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: PrimeCareColors.radarDark,
        ),
      ),

      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: const EdgeInsets.all(PrimeCareSpacing.md),
        shape: RoundedRectangleBorder(
          borderRadius: PrimeCareRadii.boardXxl,
          side: BorderSide.none, // "No-Line" Philosophy
        ),
      ),

      // Use tonal shifts for input fields instead of borders
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PrimeCareColors.slate200.withAlpha(150),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: PrimeCareRadii.boardXxl,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: PrimeCareRadii.boardXxl,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: PrimeCareRadii.boardXxl,
          borderSide: const BorderSide(color: precisionBlue, width: 2.0),
        ),
        labelStyle: GoogleFonts.inter(color: PrimeCareColors.slate500),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: precisionBlue,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          elevation: 0, // Flat design with depth via shadow
          padding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: PrimeCareRadii.boardXxl,
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ).copyWith(
          elevation: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) return 8;
            return 4;
          }),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: obsidianBase,
      primaryColor: precisionBlue,
      colorScheme: const ColorScheme.dark(
        primary: precisionBlue,
        secondary: PrimeCareColors.purple,
        surface: PrimeCareColors.slate800,
        onSurface: Colors.white,
        error: PrimeCareColors.rose,
      ),
      textTheme: _buildTextTheme(
        Colors.white,
        PrimeCareColors.slate400,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),

      cardTheme: CardThemeData(
        color: PrimeCareColors.slate800.withAlpha(200),
        elevation: 0,
        margin: const EdgeInsets.all(PrimeCareSpacing.md),
        shape: RoundedRectangleBorder(
          borderRadius: PrimeCareRadii.boardXxl,
          side: BorderSide.none, // "No-Line" Philosophy
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PrimeCareColors.slate800,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: PrimeCareRadii.boardXxl,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: PrimeCareRadii.boardXxl,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: PrimeCareRadii.boardXxl,
          borderSide: const BorderSide(color: precisionBlue, width: 2.0),
        ),
        labelStyle: GoogleFonts.inter(color: PrimeCareColors.slate400),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: precisionBlue,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          elevation: 4,
          shadowColor: precisionBlue.withAlpha(100),
          padding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: PrimeCareRadii.boardXxl,
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
