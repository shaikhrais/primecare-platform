import 'package:flutter/material.dart';

class PrimeCareTheme {
  // Nested old components for backward compatibility
  static final colors = _PrimeCareColors();
  static final typography = _PrimeCareTypography();

  // Spacing (8px grid scale)
  static const double spacing1 = 4.0;
  static const double spacing2 = 8.0;
  static const double spacing3 = 12.0;
  static const double spacing4 = 16.0;
  static const double spacing5 = 24.0;
  static const double spacing6 = 32.0;

  // Radii
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radiusFull = 9999.0;

  // Colors
  static const Color primary = Color(0xFF5654A8);
  static const Color primaryContainer = Color(0xFFE2E0FF);
  static const Color onPrimary = Colors.white;
  static const Color onPrimaryContainer = Color(0xFF130066);
  static const Color primaryFixed = Color(0xFFE0E0FF);
  static const Color primaryFixedDim = Color(0xFFBEC2FF);
  static const Color onPrimaryFixed = Color(0xFF00006E);

  static const Color secondary = Color(0xFF006948);
  static const Color secondaryContainer = Color(0xFF90F2C2);
  static const Color onSecondaryContainer = Color(0xFF002113);
  static const Color secondaryFixed = Color(0xFF90F2C2);

  static const Color tertiary = Color(0xFF6D7A72);
  static const Color tertiaryContainer = Color(0xFFF4FDFA);
  static const Color onTertiary = Colors.white;
  static const Color onTertiaryContainer = Color(0xFF27322E);
  static const Color tertiaryFixed = Color(0xFFCCE4DA);

  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);

  static const Color surface = Color(0xFFF8F9FA);
  static const Color surfaceBright = Color(0xFFFFFFFF);
  static const Color surfaceContainerHighest = Color(0xFFE0E3E5);
  static const Color surfaceContainerHigh = Color(0xFFF2F4F6);
  static const Color surfaceContainerLow = Color(0xFFFAFBFC);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF191C1B);
  static const Color onSurfaceVariant = Color(0xFF40484A);
  static const Color outline = Color(0xFF70787A);
  static const Color outlineVariant = Color(0xFFBFC8CA);
  
  static const Color textPrimary = Color(0xFF191C1B);

  // Expose legacy colors on PrimeCareTheme directly
  static const Color emeraldTeal = Color(0xFF006948);
  static const Color navyIndigo = Color(0xFF5654A8);
  static const Color slateGray = Color(0xFF6D7A72);
  static const Color coralRed = Color(0xFFBA1A1A);
  static const Color amberWarning = Color(0xFFFF9800);
  static const Color lavenderLustre = Color(0xFFE2E0FF);
  static const Color cloudGray = Color(0xFFF2F4F6);
  static const Color coralBlush = Color(0xFFFFDAD6);
  static const Color royalPurple = Color(0xFF381E72);
  static const Color brownSolid = Color(0xFF795548);


  // Material Typography (Flutter defaults approximate)
  static const TextStyle displayLarge = TextStyle(fontSize: 57, fontWeight: FontWeight.normal);
  static const TextStyle displayMedium = TextStyle(fontSize: 45, fontWeight: FontWeight.normal);
  static const TextStyle displaySmall = TextStyle(fontSize: 36, fontWeight: FontWeight.normal);
  static const TextStyle display = TextStyle(fontSize: 36, fontWeight: FontWeight.normal);
  
  static const TextStyle headlineLarge = TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
  static const TextStyle headlineMedium = TextStyle(fontSize: 28, fontWeight: FontWeight.w600);
  static const TextStyle headlineSmall = TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
  
  static const TextStyle titleLarge = TextStyle(fontSize: 22, fontWeight: FontWeight.w500);
  static const TextStyle titleMedium = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static const TextStyle titleSmall = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

  static const TextStyle bodyLarge = TextStyle(fontSize: 16, fontWeight: FontWeight.normal);
  static const TextStyle bodyMedium = TextStyle(fontSize: 14, fontWeight: FontWeight.normal);
  static const TextStyle bodySmall = TextStyle(fontSize: 12, fontWeight: FontWeight.normal);

  static const TextStyle labelLarge = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  static const TextStyle labelMedium = TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  static const TextStyle labelSmall = TextStyle(fontSize: 11, fontWeight: FontWeight.w500);
}

class _PrimeCareColors {
  Color get navyIndigo => PrimeCareTheme.navyIndigo;
  Color get emeraldTeal => PrimeCareTheme.emeraldTeal;
  Color get slateGray => PrimeCareTheme.slateGray;
  Color get surfaceContainerHighest => PrimeCareTheme.surfaceContainerHighest;
  Color get surfaceContainerHigh => PrimeCareTheme.surfaceContainerHigh;
  Color get surfaceContainerLow => PrimeCareTheme.surfaceContainerLow;
  Color get surfaceContainerLowest => PrimeCareTheme.surfaceContainerLowest;
  Color get coralRed => PrimeCareTheme.coralRed;
  Color get amberWarning => PrimeCareTheme.amberWarning;
  
  Color get lavenderLustre => PrimeCareTheme.lavenderLustre;
  Color get cloudGray => PrimeCareTheme.cloudGray;
  Color get coralBlush => PrimeCareTheme.coralBlush;
  Color get royalPurple => PrimeCareTheme.royalPurple;
  Color get brownSolid => PrimeCareTheme.brownSolid;

  Color get primary => PrimeCareTheme.primary;
  Color get secondary => PrimeCareTheme.secondary;
  Color get tertiary => PrimeCareTheme.tertiary;
  Color get error => PrimeCareTheme.error;
  Color get surface => PrimeCareTheme.surface;
  Color get outline => PrimeCareTheme.outline;
  Color get outlineVariant => PrimeCareTheme.outlineVariant;
  Color get textPrimary => PrimeCareTheme.textPrimary;
  Color get onSurface => PrimeCareTheme.onSurface;
  Color get onSurfaceVariant => PrimeCareTheme.onSurfaceVariant;
  Color get primaryContainer => PrimeCareTheme.primaryContainer;
  Color get errorContainer => PrimeCareTheme.errorContainer;
  Color get onPrimary => PrimeCareTheme.onPrimary;
  Color get onTertiary => PrimeCareTheme.onTertiary;
}

class _PrimeCareTypography {
  TextStyle get heroTitle => PrimeCareTheme.headlineLarge;
  TextStyle get h1 => PrimeCareTheme.headlineLarge;
  TextStyle get h2 => PrimeCareTheme.headlineMedium;
  TextStyle get h3 => PrimeCareTheme.titleLarge;
  TextStyle get h4 => PrimeCareTheme.titleMedium;
  TextStyle get body => PrimeCareTheme.bodyMedium;
  TextStyle get label => PrimeCareTheme.labelMedium;
  TextStyle get display => PrimeCareTheme.display;
  TextStyle get displayLarge => PrimeCareTheme.displayLarge;
  TextStyle get displayMedium => PrimeCareTheme.displayMedium;
  TextStyle get headlineSmall => PrimeCareTheme.headlineSmall;
}
