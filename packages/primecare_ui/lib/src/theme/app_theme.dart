import 'package:flutter/material.dart';
import 'theme_extension.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Theme.of(context).primaryColor,
      primaryColor: const Color(0xFF1E3A8A),
      scaffoldBackgroundColor: Colors.grey.shade50,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Color(0xFF1E3A8A),
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A), letterSpacing: -1.0),
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black87, letterSpacing: -0.5),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
        bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
      ),
      extensions: const [
        PrimeCareThemeExtension.light,
      ],
    );
  }
}
