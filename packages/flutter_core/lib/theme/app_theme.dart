// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE Classic Institutional Palette
// Layer: 01_INFRASTRUCTURE
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
        selectedLabelTextStyle: TextStyle(
          color: primary,
          fontWeight: FontWeight.bold,
        ),
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

class GovernanceThemeColors extends ThemeExtension<GovernanceThemeColors> {
  final Color? sidebarBackground;
  final Color? topbarBackground;
  final Color? sidebarTextColor;
  final Color? sidebarSelectedTextColor;
  final Color? sidebarIconColor;
  final Color? sidebarSelectedIconColor;
  final Color? sidebarSelectedTileColor;
  final Color? sidebarDividerColor;
  final Color? topbarTextColor;
  final Color? topbarSelectedTextColor;
  final Color? topbarIconColor;
  final Color? topbarSelectedIconColor;
  final Color? topbarDividerColor;

  const GovernanceThemeColors({
    this.sidebarBackground,
    this.topbarBackground,
    this.sidebarTextColor,
    this.sidebarSelectedTextColor,
    this.sidebarIconColor,
    this.sidebarSelectedIconColor,
    this.sidebarSelectedTileColor,
    this.sidebarDividerColor,
    this.topbarTextColor,
    this.topbarSelectedTextColor,
    this.topbarIconColor,
    this.topbarSelectedIconColor,
    this.topbarDividerColor,
  });

  @override
  GovernanceThemeColors copyWith({
    Color? sidebarBackground,
    Color? topbarBackground,
    Color? sidebarTextColor,
    Color? sidebarSelectedTextColor,
    Color? sidebarIconColor,
    Color? sidebarSelectedIconColor,
    Color? sidebarSelectedTileColor,
    Color? sidebarDividerColor,
    Color? topbarTextColor,
    Color? topbarSelectedTextColor,
    Color? topbarIconColor,
    Color? topbarSelectedIconColor,
    Color? topbarDividerColor,
  }) {
    return GovernanceThemeColors(
      sidebarBackground: sidebarBackground ?? this.sidebarBackground,
      topbarBackground: topbarBackground ?? this.topbarBackground,
      sidebarTextColor: sidebarTextColor ?? this.sidebarTextColor,
      sidebarSelectedTextColor: sidebarSelectedTextColor ?? this.sidebarSelectedTextColor,
      sidebarIconColor: sidebarIconColor ?? this.sidebarIconColor,
      sidebarSelectedIconColor: sidebarSelectedIconColor ?? this.sidebarSelectedIconColor,
      sidebarSelectedTileColor: sidebarSelectedTileColor ?? this.sidebarSelectedTileColor,
      sidebarDividerColor: sidebarDividerColor ?? this.sidebarDividerColor,
      topbarTextColor: topbarTextColor ?? this.topbarTextColor,
      topbarSelectedTextColor: topbarSelectedTextColor ?? this.topbarSelectedTextColor,
      topbarIconColor: topbarIconColor ?? this.topbarIconColor,
      topbarSelectedIconColor: topbarSelectedIconColor ?? this.topbarSelectedIconColor,
      topbarDividerColor: topbarDividerColor ?? this.topbarDividerColor,
    );
  }

  @override
  GovernanceThemeColors lerp(ThemeExtension<GovernanceThemeColors>? other, double t) {
    if (other is! GovernanceThemeColors) {
      return this;
    }
    return GovernanceThemeColors(
      sidebarBackground: Color.lerp(sidebarBackground, other.sidebarBackground, t),
      topbarBackground: Color.lerp(topbarBackground, other.topbarBackground, t),
      sidebarTextColor: Color.lerp(sidebarTextColor, other.sidebarTextColor, t),
      sidebarSelectedTextColor: Color.lerp(sidebarSelectedTextColor, other.sidebarSelectedTextColor, t),
      sidebarIconColor: Color.lerp(sidebarIconColor, other.sidebarIconColor, t),
      sidebarSelectedIconColor: Color.lerp(sidebarSelectedIconColor, other.sidebarSelectedIconColor, t),
      sidebarSelectedTileColor: Color.lerp(sidebarSelectedTileColor, other.sidebarSelectedTileColor, t),
      sidebarDividerColor: Color.lerp(sidebarDividerColor, other.sidebarDividerColor, t),
      topbarTextColor: Color.lerp(topbarTextColor, other.topbarTextColor, t),
      topbarSelectedTextColor: Color.lerp(topbarSelectedTextColor, other.topbarSelectedTextColor, t),
      topbarIconColor: Color.lerp(topbarIconColor, other.topbarIconColor, t),
      topbarSelectedIconColor: Color.lerp(topbarSelectedIconColor, other.topbarSelectedIconColor, t),
      topbarDividerColor: Color.lerp(topbarDividerColor, other.topbarDividerColor, t),
    );
  }
}
