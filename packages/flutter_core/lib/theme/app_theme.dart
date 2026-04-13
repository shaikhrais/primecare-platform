import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Classic Institutional Palette
  static const Color primary = Color(0xFF0D1B2A); // Deep Navy
  static const Color secondary = Color(0xFF1B263B); // Navy-Slate
  
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF8F9FA); // Clean Institutional Grey
  static const Color border = Color(0xFFE2E8F0);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        secondary: secondary,
        surface: surface,
        onSurface: const Color(0xFF1B2323),
        outline: border,
      ),
      scaffoldBackgroundColor: background,

      textTheme: TextTheme(
        displayLarge: GoogleFonts.manrope(
          fontSize: 48,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF1B2323),
        ),
        headlineSmall: GoogleFonts.manrope(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF1B2323),
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1B2323),
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: const Color(0xFF4A5555),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: border,
        space: 1,
        thickness: 1,
      ),

      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: border),
        ),
      ),

      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: primary),
        unselectedIconTheme: IconThemeData(color: Color(0xFF667171)),
        selectedLabelTextStyle: TextStyle(color: primary, fontWeight: FontWeight.bold),
        unselectedLabelTextStyle: TextStyle(color: Color(0xFF667171)),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
      ),
    );
  }
}
