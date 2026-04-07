import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Luminous Color Palette
  static const Color primary = Color(0xFF006565);
  static const Color primaryContainer = Color(0xFF008080);
  static const Color primaryFixed = Color(0xFF93F2F2);

  static const Color secondary = Color(0xFF004D4D); // darker contrast
  static const Color secondaryContainer = Color(0xFFB5EDEC);
  static const Color onSecondaryContainer = Color(0xFF002222);

  static const Color surface = Color(0xFFF6FAFA);
  static const Color surfaceContainerLow = Color(0xFFF0F4F4);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerHigh = Color(0xFFE4EAE9);

  static const Color outlineVariant = Color(0xFFBDC9C8); // Ghost border

  // Ambient Shadow - BoxShadow: 0 8px 32px rgba(24, 28, 29, 0.06)
  static final List<BoxShadow> ambientShadow = [
    BoxShadow(
      color: const Color(0xFF181C1D).withValues(alpha: 0.06),
      blurRadius: 32,
      offset: const Offset(0, 8),
    ),
  ];

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        primaryContainer: primaryContainer,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        surface: surface,
        surfaceContainerLow: surfaceContainerLow,
        surfaceContainerLowest: surfaceContainerLowest,
        surfaceContainerHighest: surfaceContainerHigh,
        outlineVariant: outlineVariant,
      ),
      scaffoldBackgroundColor: surfaceContainerLow, // Default bg

      textTheme: TextTheme(
        // Power Scale (Manrope for Display/Headline)
        displayLarge: GoogleFonts.manrope(
          fontSize: 56, // 3.5rem
          fontWeight: FontWeight.w800,
          color: const Color(0xFF1B2323),
          letterSpacing: -1,
        ),
        headlineSmall: GoogleFonts.manrope(
          fontSize: 24, // 1.5rem
          fontWeight: FontWeight.w700,
          color: const Color(0xFF1B2323),
        ),
        // Body (Inter for dense medical charts)
        titleSmall: GoogleFonts.inter(
          fontSize: 16, // 1rem
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1B2323),
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: const Color(0xFF4A5555),
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Remove dense solid 1px borders everywhere
      dividerTheme: const DividerThemeData(
        color: Colors
            .transparent, // "No-Line Rule" via global override or ghost borders
        space: 1,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceContainerHigh,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none, // No-Line rule inactive
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: primary.withValues(alpha: 0.4), // "Ghost Border" at 40%
            width: 2,
          ),
        ),
      ),
    );
  }
}
