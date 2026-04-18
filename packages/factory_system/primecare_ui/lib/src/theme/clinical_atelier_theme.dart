import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Clinical Atelier Design System
/// Implements vibrant blues, Outfit/Inter fonts, and glassmorphic 16dp corners.
class ClinicalAtelierTheme {
  // Brand Colors for Clinical Atelier
  static const Color vibrantBlue = Color(0xFF0052CC); // Vibrant Primary Blue
  static const Color vibrantLightBlue = Color(0xFF2684FF); // Accent Blue
  static const Color surfaceGlass = Color(
    0xCCFFFFFF,
  ); // 80% opacity white for glassmorphism
  static const Color surfaceGlassDark = Color(
    0xCC1E293B,
  ); // 80% opacity dark slate for dark mode

  static TextTheme _buildTextTheme(Color baseColor, Color mutedColor) {
    final baseTextTheme = GoogleFonts.interTextTheme();
    return baseTextTheme.copyWith(
      headlineLarge: GoogleFonts.outfit(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
        color: baseColor,
      ),
      headlineMedium: GoogleFonts.outfit(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.2,
        color: baseColor,
      ),
      titleLarge: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: baseColor,
      ),
      titleMedium: GoogleFonts.outfit(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      bodyLarge: GoogleFonts.inter(fontSize: 16, color: baseColor),
      bodyMedium: GoogleFonts.inter(fontSize: 14, color: mutedColor),
      labelLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(
        0xFFF0F4F8,
      ), // Soft background to let glass pop
      primaryColor: vibrantBlue,
      colorScheme: const ColorScheme.light(
        primary: vibrantBlue,
        secondary: vibrantLightBlue,
        surface: surfaceGlass,
        error: PrimeCareColors.rose,
      ),
      textTheme: _buildTextTheme(
        PrimeCareColors.radarDark,
        PrimeCareColors.slate500,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent, // For glassmorphic headers
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: PrimeCareColors.radarDark),
        titleTextStyle: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: PrimeCareColors.radarDark,
        ),
      ),

      cardTheme: CardThemeData(
        color: surfaceGlass,
        elevation: 0,
        margin: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // 16dp corners
          side: BorderSide(color: PrimeCareColors.slate200.withAlpha(100)),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: vibrantBlue,
          foregroundColor: PrimeCareColors.white,
          minimumSize: const Size(double.infinity, 56),
          elevation: 4,
          shadowColor: vibrantBlue.withAlpha(100),
          padding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PrimeCareColors.white.withAlpha(200),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: PrimeCareColors.slate200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: PrimeCareColors.slate200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: vibrantBlue, width: 2.0),
        ),
        labelStyle: GoogleFonts.inter(color: PrimeCareColors.slate500),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: surfaceGlass,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: PrimeCareColors.radarDark,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: PrimeCareColors.radarDark,
      primaryColor: vibrantBlue,
      colorScheme: const ColorScheme.dark(
        primary: vibrantBlue,
        secondary: vibrantLightBlue,
        surface: surfaceGlassDark,
        error: PrimeCareColors.rose,
      ),
      textTheme: _buildTextTheme(
        PrimeCareColors.white,
        PrimeCareColors.slate400,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent, // For glassmorphic headers
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: PrimeCareColors.white),
        titleTextStyle: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: PrimeCareColors.white,
        ),
      ),

      cardTheme: CardThemeData(
        color: surfaceGlassDark,
        elevation: 0,
        margin: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // 16dp corners
          side: BorderSide(color: PrimeCareColors.slate700.withAlpha(100)),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: vibrantBlue,
          foregroundColor: PrimeCareColors.white,
          minimumSize: const Size(double.infinity, 56),
          elevation: 4,
          shadowColor: vibrantBlue.withAlpha(50),
          padding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PrimeCareColors.slate800.withAlpha(150),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: PrimeCareColors.slate700),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: PrimeCareColors.slate700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: vibrantBlue, width: 2.0),
        ),
        labelStyle: GoogleFonts.inter(color: PrimeCareColors.slate400),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: surfaceGlassDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: PrimeCareColors.white,
        ),
      ),
    );
  }
}
