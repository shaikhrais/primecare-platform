// Governance - Category: service | Purpose: Static utility class for PrimeCare colors used across the platform. Brand Colors Surface & Background
import 'package:flutter/material.dart';
import 'package:flutter_core/theme/app_theme.dart';
import 'package:flutter_core/theme/theme_config_generated.dart';

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
  static const Color dashboardBackground = Color(0xFFF1F5F9);

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
  static const Color successContainer = Color(0xFFD1FAE5);
  static const Color onSuccessContainer = Color(0xFF065F46);

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

  static const Color sidebarBackground = Color(0xFF0F172A);
  static const Color topbarBackground = Color(0xFF0F172A);

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
  final Color dashboardBackground;
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
  final Color successContainer;
  final Color warning;
  final Color success;
  final Color divider;
  final Color border;
  final Color sidebarBackground;
  final Color topbarBackground;
  final Color sidebarTextColor;
  final Color sidebarSelectedTextColor;
  final Color sidebarIconColor;
  final Color sidebarSelectedIconColor;
  final Color sidebarSelectedTileColor;
  final Color sidebarDividerColor;
  final Color topbarTextColor;
  final Color topbarSelectedTextColor;
  final Color topbarIconColor;
  final Color topbarSelectedIconColor;
  final Color topbarDividerColor;

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
    this.dashboardBackground = PrimeCareColors.dashboardBackground,
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
    this.successContainer = PrimeCareColors.successContainer,
    this.warning = const Color(0xFFF59E0B),
    this.success = PrimeCareColors.success,
    this.divider = PrimeCareColors.outlineVariant,
    this.border = PrimeCareColors.outlineVariant,
    this.sidebarBackground = PrimeCareColors.sidebarBackground,
    this.topbarBackground = PrimeCareColors.topbarBackground,
    this.sidebarTextColor = const Color(0xB3FFFFFF),
    this.sidebarSelectedTextColor = const Color(0xFFFFFFFF),
    this.sidebarIconColor = const Color(0xB3FFFFFF),
    this.sidebarSelectedIconColor = const Color(0xFFFFFFFF),
    this.sidebarSelectedTileColor = const Color(0x26FFFFFF),
    this.sidebarDividerColor = const Color(0x1FFFFFFF),
    this.topbarTextColor = const Color(0xB3FFFFFF),
    this.topbarSelectedTextColor = const Color(0xFFFFFFFF),
    this.topbarIconColor = const Color(0xB3FFFFFF),
    this.topbarSelectedIconColor = const Color(0xFFFFFFFF),
    this.topbarDividerColor = const Color(0x1FFFFFFF),
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

  factory PrimeColors.fromPalette(AppThemePalette palette) {
    // Estimate text/icon brightness based on background luminance
    final isDarkSidebar = palette.sidebarBackground.computeLuminance() < 0.5;
    final isDarkTopbar = palette.topbarBackground.computeLuminance() < 0.5;

    return PrimeColors(
      primary: palette.primary,
      primaryContainer: palette.primaryContainer,
      onPrimary: palette.onPrimary,
      secondary: palette.secondary,
      secondaryContainer: palette.secondaryContainer,
      background: palette.background,
      surface: palette.surface,
      divider: palette.divider,
      sidebarBackground: palette.sidebarBackground,
      topbarBackground: palette.topbarBackground,
      sidebarTextColor: isDarkSidebar ? const Color(0xB3FFFFFF) : const Color(0xB3000000),
      sidebarSelectedTextColor: isDarkSidebar ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
      sidebarIconColor: isDarkSidebar ? const Color(0xB3FFFFFF) : const Color(0xB3000000),
      sidebarSelectedIconColor: isDarkSidebar ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
      sidebarSelectedTileColor: isDarkSidebar ? const Color(0x26FFFFFF) : const Color(0x0D000000),
      sidebarDividerColor: isDarkSidebar ? const Color(0x1FFFFFFF) : const Color(0x0D000000),
      topbarTextColor: isDarkTopbar ? const Color(0xB3FFFFFF) : const Color(0xB3000000),
      topbarSelectedTextColor: isDarkTopbar ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
      topbarIconColor: isDarkTopbar ? const Color(0xB3FFFFFF) : const Color(0xB3000000),
      topbarSelectedIconColor: isDarkTopbar ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
      topbarDividerColor: isDarkTopbar ? const Color(0x1FFFFFFF) : const Color(0x0D000000),
    );
  }

  final Color onErrorContainer;

  Color get onBackground => onSurface;
  Color get textSecondary => onSurfaceVariant;
  Color get warningContainer => warning.withValues(alpha: 0.15);

  PrimeColors copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? secondary,
    Color? tertiary,
    Color? background,
    Color? dashboardBackground,
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
    Color? errorContainer,
    Color? successContainer,
    Color? warning,
    Color? success,
    Color? divider,
    Color? border,
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
    Color? onErrorContainer,
  }) {
    return PrimeColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      background: background ?? this.background,
      dashboardBackground: dashboardBackground ?? this.dashboardBackground,
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
      errorContainer: errorContainer ?? this.errorContainer,
      successContainer: successContainer ?? this.successContainer,
      warning: warning ?? this.warning,
      success: success ?? this.success,
      divider: divider ?? this.divider,
      border: border ?? this.border,
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
  final double xxxl;
  final double containerPadding;
  final double cardGap;

  const PrimeSpacing({
    this.xs = 4.0,
    this.sm = 8.0,
    this.md = 16.0,
    this.lg = 24.0,
    this.xl = 32.0,
    this.xxl = 48.0,
    this.xxxl = 64.0,
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

  TextStyle get h4 => const TextStyle(
        fontFamily: 'Manrope',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: PrimeCareColors.onSurface,
        height: 24 / 18,
      );

  TextStyle get h5 => const TextStyle(
        fontFamily: 'Manrope',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: PrimeCareColors.onSurface,
        height: 22 / 16,
      );

  TextStyle get subtitle1 => const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: PrimeCareColors.onSurface,
        height: 24 / 16,
      );

  TextStyle get subtitle2 => const TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: PrimeCareColors.onSurface,
        height: 20 / 14,
      );

  TextStyle get button => labelBold;

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
      extensions: [
        GovernanceThemeColors(
          sidebarBackground: colors.sidebarBackground,
          topbarBackground: colors.topbarBackground,
          sidebarTextColor: colors.sidebarTextColor,
          sidebarSelectedTextColor: colors.sidebarSelectedTextColor,
          sidebarIconColor: colors.sidebarIconColor,
          sidebarSelectedIconColor: colors.sidebarSelectedIconColor,
          sidebarSelectedTileColor: colors.sidebarSelectedTileColor,
          sidebarDividerColor: colors.sidebarDividerColor,
          topbarTextColor: colors.topbarTextColor,
          topbarSelectedTextColor: colors.topbarSelectedTextColor,
          topbarIconColor: colors.topbarIconColor,
          topbarSelectedIconColor: colors.topbarSelectedIconColor,
          topbarDividerColor: colors.topbarDividerColor,
        ),
      ],
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
