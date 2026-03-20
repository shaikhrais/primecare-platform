import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimeCareTheme {
  // --- The "Basic" Enterprise Medical Palette ---
  // A timeless, highly trusted color array focusing on unpretentious clarity.
  static const Color primaryColor = Color(0xFF1E40AF); // Deep Royal Blue (Trust, Health, Corporate)
  static const Color accentColor = Color(0xFF0D9488); // Teal/Medical Green (Clean, actionable)
  static const Color backgroundColor = Color(0xFFF9FAFB); // Pure Cool Off-White (No distracting tints)
  static const Color surfaceColor = Colors.white; // Absolute White
  static const Color textPrimary = Color(0xFF111827); // Basic deep gray-black (readable)
  static const Color textSecondary = Color(0xFF6B7280); // Classic medium gray

  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        surface: surfaceColor,
      ),
      
      // Clean, Basic Typography
      textTheme: baseTextTheme.copyWith(
        headlineLarge: GoogleFonts.plusJakartaSans(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: -0.5, color: textPrimary),
        headlineMedium: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -0.2, color: textPrimary),
        titleLarge: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold, color: textPrimary),
        bodyLarge: GoogleFonts.inter(fontSize: 16, color: textPrimary),
        bodyMedium: GoogleFonts.inter(fontSize: 14, color: textSecondary),
      ),

      // Minimalist AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: primaryColor),
        titleTextStyle: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 22, fontWeight: FontWeight.bold, color: textPrimary),
      ),

      // Uncluttered Cards with basic, soft elevation
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),

      // Solid, legible primary buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56), 
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
      ),

      // Clean inputs with clear borders
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: const BorderSide(color: Color(0xFFD1D5DB), width: 1.0)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1.0)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: const BorderSide(color: primaryColor, width: 2.0)),
        labelStyle: GoogleFonts.inter(color: textSecondary),
      ),
      
      dividerTheme: const DividerThemeData(color: Color(0xFFF3F4F6), thickness: 1, space: 24),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: PrimeCareTransitionBuilder(),
          TargetPlatform.iOS: PrimeCareTransitionBuilder(),
          TargetPlatform.macOS: PrimeCareTransitionBuilder(),
        },
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      useMaterial3: true,
      // Minimal dark mapping
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF60A5FA), // Lighter blue for dark mode visibility
        secondary: accentColor,
      ),
    );
  }
}

class PrimeCareTransitionBuilder extends PageTransitionsBuilder {
  const PrimeCareTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child); // Basic, professional fade instead of bouncy iOS slides
  }
}
