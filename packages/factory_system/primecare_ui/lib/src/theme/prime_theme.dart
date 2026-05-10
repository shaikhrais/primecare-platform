import 'package:flutter/material.dart';

/// Static utility class for PrimeCare colors used across the platform.
class PrimeCareColors {
  // Brand Colors
  static const Color primary = Color(0xFF004AC6);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF2563EB);
  static const Color onPrimaryContainer = Color(0xFFEEEFFF);
  static const Color inversePrimary = Color(0xFFB4C5FF);

  static const Color secondary = Color(0xFF4059AA);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFF8FA7FE);
  static const Color onSecondaryContainer = Color(0xFF1D3989);

  static const Color tertiary = Color(0xFF943700);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFBC4800);
  static const Color onTertiaryContainer = Color(0xFFFFEDE6);

  // Surface & Background
  static const Color background = Color(0xFFF7F9FB);
  static const Color onBackground = Color(0xFF191C1E);
  static const Color surface = Color(0xFFF7F9FB);
  static const Color onSurface = Color(0xFF191C1E);
  static const Color surfaceVariant = Color(0xFFE0E3E5);
  static const Color onSurfaceVariant = Color(0xFF434655);

  // Extended Surfaces
  static const Color surfaceDim = Color(0xFFD8DADC);
  static const Color surfaceBright = Color(0xFFF7F9FB);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F4F6);
  static const Color surfaceContainer = Color(0xFFECEEF0);
  static const Color surfaceContainerHigh = Color(0xFFE6E8EA);
  static const Color surfaceContainerHighest = Color(0xFFE0E3E5);

  static const Color inverseSurface = Color(0xFF2D3133);
  static const Color inverseOnSurface = Color(0xFFEFF1F3);
  static const Color outline = Color(0xFF737686);
  static const Color outlineVariant = Color(0xFFC3C6D7);
  static const Color surfaceTint = Color(0xFF0053DB);

  // Error
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // Success
  static const Color success = Color(0xFF10B981);
  static const Color onSuccess = Color(0xFFFFFFFF);

  // Fixed Variants
  static const Color primaryFixed = Color(0xFFDBE1FF);
  static const Color primaryFixedDim = Color(0xFFB4C5FF);
  static const Color onPrimaryFixed = Color(0xFF00174B);
  static const Color onPrimaryFixedVariant = Color(0xFF003EA8);

  static const Color secondaryFixed = Color(0xFFDCE1FF);
  static const Color secondaryFixedDim = Color(0xFFB6C4FF);
  static const Color onSecondaryFixed = Color(0xFF00164E);
  static const Color onSecondaryFixedVariant = Color(0xFF264191);

  static const Color tertiaryFixed = Color(0xFFFFDBCD);
  static const Color tertiaryFixedDim = Color(0xFFFFB596);
  static const Color onTertiaryFixed = Color(0xFF360F00);
  static const Color onTertiaryFixedVariant = Color(0xFF7D2D00);

  const PrimeCareColors._();
}

/// Standardized color palette for the PrimeCare UI Factory.
class PrimeColors {
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color inversePrimary;
  final Color secondary;
  final Color secondaryContainer;
  final Color tertiary;
  final Color tertiaryContainer;
  final Color background;
  final Color surface;
  final Color onSurface;
  final Color onSurfaceVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color surfaceTint;
  final Color outline;
  final Color outlineVariant;
  final Color error;
  final Color errorContainer;
  final Color warning;
  final Color success;
  final Color divider;
  final Color border;

  // Fixed Variants
  final Color primaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixed;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixed;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixed;
  final Color onTertiaryFixedVariant;

  const PrimeColors({
    this.primary = PrimeCareColors.primary,
    this.onPrimary = PrimeCareColors.onPrimary,
    this.primaryContainer = PrimeCareColors.primaryContainer,
    this.inversePrimary = PrimeCareColors.inversePrimary,
    this.secondary = PrimeCareColors.secondary,
    this.secondaryContainer = PrimeCareColors.secondaryContainer,
    this.tertiary = PrimeCareColors.tertiary,
    this.tertiaryContainer = PrimeCareColors.tertiaryContainer,
    this.background = PrimeCareColors.background,
    this.surface = PrimeCareColors.surface,
    this.onSurface = PrimeCareColors.onSurface,
    this.onSurfaceVariant = PrimeCareColors.onSurfaceVariant,
    this.surfaceDim = PrimeCareColors.surfaceDim,
    this.surfaceBright = PrimeCareColors.surfaceBright,
    this.surfaceContainerLowest = PrimeCareColors.surfaceContainerLowest,
    this.surfaceContainerLow = PrimeCareColors.surfaceContainerLow,
    this.surfaceContainer = PrimeCareColors.surfaceContainer,
    this.surfaceContainerHigh = PrimeCareColors.surfaceContainerHigh,
    this.surfaceContainerHighest = PrimeCareColors.surfaceContainerHighest,
    this.inverseSurface = PrimeCareColors.inverseSurface,
    this.inverseOnSurface = PrimeCareColors.inverseOnSurface,
    this.surfaceTint = PrimeCareColors.surfaceTint,
    this.outline = PrimeCareColors.outline,
    this.outlineVariant = PrimeCareColors.outlineVariant,
    this.error = PrimeCareColors.error,
    this.errorContainer = PrimeCareColors.errorContainer,
    this.warning = const Color(0xFFF59E0B),
    this.success = PrimeCareColors.success,
    this.divider = PrimeCareColors.outlineVariant,
    this.border = PrimeCareColors.outlineVariant,
    this.primaryFixed = PrimeCareColors.primaryFixed,
    this.primaryFixedDim = PrimeCareColors.primaryFixedDim,
    this.onPrimaryFixed = PrimeCareColors.onPrimaryFixed,
    this.onPrimaryFixedVariant = PrimeCareColors.onPrimaryFixedVariant,
    this.secondaryFixed = PrimeCareColors.secondaryFixed,
    this.secondaryFixedDim = PrimeCareColors.secondaryFixedDim,
    this.onSecondaryFixed = PrimeCareColors.onSecondaryFixed,
    this.onSecondaryFixedVariant = PrimeCareColors.onSecondaryFixedVariant,
    this.tertiaryFixed = PrimeCareColors.tertiaryFixed,
    this.tertiaryFixedDim = PrimeCareColors.tertiaryFixedDim,
    this.onTertiaryFixed = PrimeCareColors.onTertiaryFixed,
    this.onTertiaryFixedVariant = PrimeCareColors.onTertiaryFixedVariant,
    this.onErrorContainer = PrimeCareColors.onErrorContainer,
  });

  final Color onErrorContainer;

  PrimeColors copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? secondary,
    Color? tertiary,
    Color? background,
    Color? surface,
    Color? onSurface,
    Color? onSurfaceVariant,
    Color? surfaceContainer,
    Color? surfaceContainerLow,
    Color? surfaceContainerHigh,
    Color? surfaceContainerLowest,
    Color? surfaceContainerHighest,
    Color? textSecondary,
    Color? slate400,
    Color? outline,
    Color? outlineVariant,
    Color? error,
    Color? warning,
    Color? success,
    Color? divider,
    Color? border,
    Color? onErrorContainer,
  }) {
    return PrimeColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      surfaceContainerLow: surfaceContainerLow ?? this.surfaceContainerLow,
      surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
      surfaceContainerLowest:
          surfaceContainerLowest ?? this.surfaceContainerLowest,
      surfaceContainerHighest:
          surfaceContainerHighest ?? this.surfaceContainerHighest,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      success: success ?? this.success,
      divider: divider ?? this.divider,
      border: border ?? this.border,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
    );
  }
}

/// Standardized spacing for the PrimeCare UI Factory.
class PrimeSpacing {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double containerPadding;
  final double cardGap;

  const PrimeSpacing({
    this.xs = 4.0,
    this.sm = 8.0,
    this.md = 16.0,
    this.lg = 24.0,
    this.xl = 32.0,
    this.xxl = 48.0,
    this.containerPadding = 24.0,
    this.cardGap = 16.0,
  });

  /// Multiplication operator to allow scale-based spacing (e.g., theme.spacing * 2).
  /// Uses 'sm' (8.0) as the base unit.
  double operator *(double factor) => sm * factor;
}

class PrimeTypography {
  final Color defaultColor;
  final Color secondaryColor;

  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelBold;
  final TextStyle labelMedium;

  final TextStyle labelSmall;

  const PrimeTypography({
    this.defaultColor = PrimeCareColors.onSurface,
    this.secondaryColor = PrimeCareColors.onSurfaceVariant,
  }) : h1 = const TextStyle(
         fontFamily: 'Manrope',
         fontSize: 30,
         fontWeight: FontWeight.w700,
         color: PrimeCareColors.onSurface,
         height: 38 / 30,
         letterSpacing: -30 * 0.02,
       ),
       h2 = const TextStyle(
         fontFamily: 'Manrope',
         fontSize: 24,
         fontWeight: FontWeight.w600,
         color: PrimeCareColors.onSurface,
         height: 32 / 24,
         letterSpacing: -24 * 0.01,
       ),
       h3 = const TextStyle(
         fontFamily: 'Manrope',
         fontSize: 20,
         fontWeight: FontWeight.w600,
         color: PrimeCareColors.onSurface,
         height: 28 / 20,
       ),
       bodyLarge = const TextStyle(
         fontFamily: 'Inter',
         fontSize: 16,
         fontWeight: FontWeight.w400,
         color: PrimeCareColors.onSurface,
         height: 24 / 16,
       ),
       bodyMedium = const TextStyle(
         fontFamily: 'Inter',
         fontSize: 14,
         fontWeight: FontWeight.w400,
         color: PrimeCareColors.onSurface,
         height: 20 / 14,
       ),
       bodySmall = const TextStyle(
         fontFamily: 'Inter',
         fontSize: 13,
         fontWeight: FontWeight.w400,
         color: PrimeCareColors.onSurface,
         height: 18 / 13,
       ),
       labelBold = const TextStyle(
         fontFamily: 'Inter',
         fontSize: 12,
         fontWeight: FontWeight.w600,
         color: PrimeCareColors.onSurface,
         height: 16 / 12,
         letterSpacing: 12 * 0.05,
       ),
       labelMedium = const TextStyle(
         fontFamily: 'Inter',
         fontSize: 12,
         fontWeight: FontWeight.w500,
         color: PrimeCareColors.onSurfaceVariant,
         height: 16 / 12,
       ),
       labelSmall = const TextStyle(
         fontFamily: 'Inter',
         fontSize: 11,
         fontWeight: FontWeight.w500,
         color: PrimeCareColors.onSurfaceVariant,
         height: 14 / 11,
       );
}

/// A structured theme data object used across the PrimeCare platform.
class PrimeThemeData {
  final PrimeColors colors;
  final PrimeTypography typography;
  final PrimeSpacing spacing;
  final double radiusXs;
  final double radiusSm;
  final double radiusDefault;
  final double radiusMd;
  final double radiusLg;
  final double radiusXl;
  final double radiusFull;
  final List<BoxShadow> shadowsSurface1;
  final List<BoxShadow> shadowsSurface2;

  const PrimeThemeData({
    this.colors = const PrimeColors(),
    this.typography = const PrimeTypography(),
    this.spacing = const PrimeSpacing(),
    this.radiusXs = 4.0, // 0.25rem
    this.radiusSm = 8.0, // DEFAULT (0.5rem)
    this.radiusDefault = 12.0, // md (0.75rem)
    this.radiusMd = 16.0, // lg (1rem)
    this.radiusLg = 24.0, // xl (1.5rem)
    this.radiusXl = 32.0,
    this.radiusFull = 9999.0,
    this.shadowsSurface1 = const [
      BoxShadow(
        color: Color(0x0D1E3A8A), // rgba(30, 58, 138, 0.05)
        blurRadius: 12,
        offset: Offset(0, 4),
      ),
    ],
    this.shadowsSurface2 = const [
      BoxShadow(
        color: Color(0x1A1E3A8A), // rgba(30, 58, 138, 0.1)
        blurRadius: 24,
        offset: Offset(0, 12),
      ),
    ],
  });

  /// Converts PrimeThemeData to standard Flutter ThemeData for global application.
  ThemeData toThemeData() {
    return ThemeData(
      useMaterial3: true,
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.background,
      dividerColor: colors.divider,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: colors.primary,
        onPrimary: colors.onPrimary,
        primaryContainer: colors.primaryContainer,
        secondary: colors.secondary,
        onSecondary: Colors.white,
        tertiary: colors.tertiary,
        onTertiary: Colors.white,
        surface: colors.surface,
        onSurface: colors.onSurface,
        error: colors.error,
        onError: Colors.white,
        outline: colors.outline,
        surfaceContainer: colors.surfaceContainer,
      ),
      dividerTheme: DividerThemeData(
        color: colors.divider,
        thickness: 1,
        space: 1,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          side: BorderSide(color: colors.divider),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusDefault),
          borderSide: BorderSide(color: colors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusDefault),
          borderSide: BorderSide(color: colors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusDefault),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        labelStyle: typography.labelMedium,
        hintStyle: typography.bodyMedium.copyWith(
          color: colors.onSurfaceVariant,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusDefault),
          ),
          textStyle: typography.labelBold,
        ),
      ),
    );
  }
}

/// InheritedWidget for the PrimeCare theme system.
class PrimeTheme extends InheritedWidget {
  final PrimeThemeData data;

  const PrimeTheme({required this.data, required super.child, super.key});

  static PrimeThemeData of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<PrimeTheme>();
    return provider?.data ?? const PrimeThemeData();
  }

  @override
  bool updateShouldNotify(PrimeTheme oldWidget) => data != oldWidget.data;
}

/// Extension to provide easy access to the PrimeThemeData from the context.
extension PrimeThemeExtension on BuildContext {
  PrimeThemeData get theme => PrimeTheme.of(this);
}
