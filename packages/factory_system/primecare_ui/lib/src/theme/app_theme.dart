// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/theme/theme_extension.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.indigo,
      primaryColor: const Color(0xFF1E3A8A),
      scaffoldBackgroundColor: PrimeCareColors.slate50,
      appBarTheme: AppBarTheme(
        backgroundColor: PrimeCareColors.white,
        foregroundColor: PrimeCareColors.black.withValues(alpha: 0.87),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Color(0xFF1E3A8A),
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1E3A8A),
          letterSpacing: -1.0,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: PrimeCareColors.black.withValues(alpha: 0.87),
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: PrimeCareColors.black.withValues(alpha: 0.87),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: PrimeCareColors.black.withValues(alpha: 0.87),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: PrimeCareColors.black.withValues(alpha: 0.87),
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: PrimeCareColors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: PrimeCareColors.white,
      ),
      extensions: const [PrimeCareThemeExtension.light],
    );
  }
}
