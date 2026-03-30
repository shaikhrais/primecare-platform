import 'package:flutter/material.dart';

class AppColors {
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color textMain;
  final Color textMuted;
  final Color primary;
  final Color accent;
  final Color error;
  final Color border;

  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.textMain,
    required this.textMuted,
    required this.primary,
    required this.accent,
    required this.error,
    required this.border,
  });

  factory AppColors.light() {
    return const AppColors(
      background: Color(0xFFF1F5F9), // Slate 50
      surface: Color(0xFFFFFFFF),
      surfaceVariant: Color(0xFFF8FAFC), // Sidebar backgrounds
      textMain: Color(0xFF0F172A), // Slate 900
      textMuted: Color(0xFF64748B), // Slate 500
      primary: Color(0xFF38BDF8),
      accent: Color(0xFF3B82F6), // Blue 500
      error: Color(0xFFE11D48),
      border: Color(0xFFE2E8F0),
    );
  }

  factory AppColors.dark() {
    return const AppColors(
      background: Color(0xFF0F172A), // Slate 900
      surface: Color(0xFF1E293B), // Slate 800
      surfaceVariant: Color(0xFF334155), // Slate 700
      textMain: Color(0xFFF8FAFC), // Slate 50
      textMuted: Color(0xFF94A3B8), // Slate 400
      primary: Color(0xFF38BDF8),
      accent: Color(0xFF3B82F6), // Blue 500
      error: Color(0xFFE11D48),
      border: Color(0xFF334155),
    );
  }
}

class AppThemeState {
  final ThemeMode mode;
  final AppColors colors;

  const AppThemeState({
    required this.mode,
    required this.colors,
  });
}
