import 'package:flutter/material.dart';
import 'colors.dart';

/// Centralized Design System that serves as the single source of truth for UI aesthetics.
/// Completely decoupled from BuildContext or ThemeExtension to ensure easy universal access.
class PrimeCareDesignSystem {
  static bool _isDarkMode = false;

  /// Globally toggle between dark mode and light mode
  static void setDarkMode(bool isDark) {
    _isDarkMode = isDark;
  }

  static Color get surfaceElevated =>
      _isDarkMode ? PrimeCareColors.slate800 : Colors.white;
  static Color get borderSubtle =>
      _isDarkMode ? PrimeCareColors.slate700 : PrimeCareColors.slate200;
  static Color get textMuted =>
      _isDarkMode ? PrimeCareColors.slate400 : PrimeCareColors.slate500;

  // Semantic Colors (Institutional Muted Tones)
  static Color get successSurface => _isDarkMode
      ? PrimeCareColors.emerald.withValues(alpha: 0.15)
      : const Color(0xFFF0FDF4);
  static Color get dangerSurface => _isDarkMode
      ? PrimeCareColors.rose.withValues(alpha: 0.15)
      : const Color(0xFFFEF2F2);
  static Color get successText => PrimeCareColors.emerald;
  static Color get dangerText => PrimeCareColors.rose;
}
