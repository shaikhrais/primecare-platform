import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
export 'theme_tokens.dart';

/// Centralized Design System that serves as the single source of truth for UI aesthetics.
/// Provides semantic tokens for institutional consistency and density-aware scaling.
class PrimeCareDesignSystem {
  static bool _isDarkMode = false;

  /// Globally toggle between dark mode and light mode
  static void setDarkMode(bool isDark) {
    _isDarkMode = isDark;
  }

  /// Hook to access tokens within a build context
  static PrimeCareDesignSystem of(BuildContext context) {
    return PrimeCareDesignSystem();
  }

  /// Semantic Color Tokens
  PrimeCareColorTokens get colors =>
      _isDarkMode ? _DarkTokens() : _LightTokens();

  // Static Getters for simplified access
  static Color get surfaceElevated =>
      _isDarkMode ? PrimeCareColors.slate800 : PrimeCareColors.white;
  static Color get borderSubtle =>
      _isDarkMode ? PrimeCareColors.slate700 : PrimeCareColors.slate200;
  static Color get textMuted =>
      _isDarkMode ? PrimeCareColors.slate400 : PrimeCareColors.slate500;

  // Static Semantic Access for legacy components
  static Color get successSurface => _isDarkMode
      ? PrimeCareColors.emerald.withValues(alpha: 0.15)
      : const Color(0xFFF0FDF4);
  static Color get dangerSurface => _isDarkMode
      ? PrimeCareColors.rose.withValues(alpha: 0.15)
      : const Color(0xFFFEF2F2);
  static Color get successText => PrimeCareColors.emerald;
  static Color get dangerText => PrimeCareColors.rose;

  /// Institutional Material Theme (Light)
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF8FAFC),
  );

  /// Institutional Material Theme (Dark)
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: PrimeCareColors.radarDark,
  );

  /// Standard brand color used across the platform
  static Color get primaryBrand => PrimeCareColors.skyBlue;
}

abstract class PrimeCareColorTokens {
  Color get primary;
  Color get secondary;
  Color get surface;
  Color get background;
  Color get borderSubtle;
  Color get textPrimary;
  Color get textSecondary;
  Color get textTertiary;
  Color get shadow;
  Color get success;
  Color get danger;
  Color get warning;
  Color get info;
  Color get successSurface;
  Color get dangerSurface;
  Color get warningSurface;
  Color get infoSurface;
  Color get error;
}

class _LightTokens implements PrimeCareColorTokens {
  @override
  Color get primary => PrimeCareColors.skyBlue;
  @override
  Color get secondary => PrimeCareColors.purple;
  @override
  Color get surface => PrimeCareColors.white;
  @override
  Color get background => const Color(0xFFF8FAFC);
  @override
  Color get borderSubtle => PrimeCareColors.slate200;
  @override
  Color get textPrimary => PrimeCareColors.radarDark;
  @override
  Color get textSecondary => PrimeCareColors.slate500;
  @override
  Color get textTertiary => PrimeCareColors.slate400;
  @override
  Color get shadow => const Color(0x0A000000);
  @override
  Color get success => PrimeCareColors.emerald;
  @override
  Color get danger => PrimeCareColors.rose;
  @override
  Color get warning => PrimeCareColors.amber;
  @override
  Color get info => PrimeCareColors.skyBlue;
  @override
  Color get successSurface => const Color(0xFFF0FDF4);
  @override
  Color get dangerSurface => const Color(0xFFFEF2F2);
  @override
  Color get warningSurface => const Color(0xFFFFFBEB);
  @override
  Color get infoSurface => const Color(0xFFF0F9FF);
  @override
  Color get error => danger;
}

class _DarkTokens implements PrimeCareColorTokens {
  @override
  Color get primary => PrimeCareColors.skyBlue;
  @override
  Color get secondary => PrimeCareColors.purple;
  @override
  Color get surface => PrimeCareColors.slate800;
  @override
  Color get background => PrimeCareColors.radarDark;
  @override
  Color get borderSubtle => PrimeCareColors.slate700;
  @override
  Color get textPrimary => PrimeCareColors.white;
  @override
  Color get textSecondary => PrimeCareColors.slate400;
  @override
  Color get textTertiary => PrimeCareColors.slate500;
  @override
  Color get shadow => const Color(0x33000000);
  @override
  Color get success => PrimeCareColors.emerald;
  @override
  Color get danger => PrimeCareColors.rose;
  @override
  Color get warning => PrimeCareColors.amber;
  @override
  Color get info => PrimeCareColors.skyBlue;
  @override
  Color get successSurface => PrimeCareColors.emerald.withValues(alpha: 0.15);
  @override
  Color get dangerSurface => PrimeCareColors.rose.withValues(alpha: 0.15);
  @override
  Color get warningSurface => PrimeCareColors.amber.withValues(alpha: 0.15);
  @override
  Color get infoSurface => PrimeCareColors.skyBlue.withValues(alpha: 0.15);
  @override
  Color get error => danger;
}
