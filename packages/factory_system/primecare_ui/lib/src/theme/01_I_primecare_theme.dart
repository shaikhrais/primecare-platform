// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primecare_ui/src/theme/01_I_theme_tokens.dart';

class PrimeCareTheme {
  // --- The Enterprise Semantic Medical Palette ---

  static TextTheme _buildTextTheme(Color baseColor, Color mutedColor) {
    final baseTextTheme = GoogleFonts.interTextTheme();
    return baseTextTheme.copyWith(
      headlineLarge: GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
        color: baseColor,
      ),
      headlineMedium: GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.2,
        color: baseColor,
      ),
      titleLarge: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: baseColor,
      ),
      titleMedium: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: baseColor,
      ),
      bodyLarge: GoogleFonts.inter(fontSize: 16, color: baseColor),
      bodyMedium: GoogleFonts.inter(fontSize: 14, color: mutedColor),
      labelLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
    );
  }

  // --- Provider & Typed Data Access ---

  static Color get primary => PrimeCareColors.skyBlue;
  static Color get secondary => PrimeCareColors.emerald;
  static Color get error => PrimeCareColors.rose;
  static Color get surface => PrimeCareColors.white;
  static Color get outline => PrimeCareColors.slate200;
  static Color get outlineVariant => PrimeCareColors.slate300;
  static Color get primaryContainer => PrimeCareColors.skyBlue.withValues(alpha: 0.1);
  static Color get onPrimaryContainer => PrimeCareColors.skyBlue;
  static Color get onSurfaceVariant => PrimeCareColors.slate500;

  static const double spacing1 = PrimeCareSpacing.xs;
  static const double spacing2 = PrimeCareSpacing.sm;
  static const double spacing3 = PrimeCareSpacing.md;
  static const double spacing4 = PrimeCareSpacing.lg;
  static const double spacing5 = PrimeCareSpacing.xl;
  static const double spacing6 = PrimeCareSpacing.xxl;

  static double get radiusSm => PrimeCareRadii.sm;
  static double get radiusMd => PrimeCareRadii.md;
  static double get radiusLg => PrimeCareRadii.lg;
  static double get radiusXl => PrimeCareRadii.xl;

  static TextStyle get headlineMedium => GoogleFonts.plusJakartaSans(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: PrimeCareColors.radarDark,
  );
  
  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    color: PrimeCareColors.slate500,
  );
  
  static TextStyle get titleMedium => GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: PrimeCareColors.radarDark,
  );
  
  static TextStyle get labelMedium => GoogleFonts.inter(
    fontSize: 12,
    color: PrimeCareColors.slate500,
    fontWeight: FontWeight.bold,
  );
  
  static TextStyle get labelSmall => GoogleFonts.inter(
    fontSize: 11,
    color: PrimeCareColors.slate500,
  );

  /// Access the hardened theme data from the current context.
  static PrimeCareThemeData of(BuildContext context) {
    return PrimeCareThemeData(Theme.of(context).brightness);
  }

  // ============== ENTERPRISE LIGHT THEME ==============
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: PrimeCareColors.white,
      primaryColor: PrimeCareColors.skyBlue,
      colorScheme: const ColorScheme.light(
        primary: PrimeCareColors.skyBlue,
        secondary: PrimeCareColors.emerald,
        surface: PrimeCareColors.white,
        error: PrimeCareColors.rose,
      ),

      textTheme: _buildTextTheme(
        PrimeCareColors.radarDark,
        PrimeCareColors.slate500,
      ),

      // Strict Component Parameters Native Binding
      appBarTheme: const AppBarTheme(
        backgroundColor: PrimeCareColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: PrimeCareColors.radarDark),
        titleTextStyle: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: PrimeCareColors.radarDark,
        ),
      ),

      cardTheme: CardThemeData(
        color: PrimeCareColors.white,
        elevation: 0,
        margin: PrimeCareSpacing.edgeAllMd,
        shape: RoundedRectangleBorder(
          borderRadius: PrimeCareRadii.boardLg,
          side: const BorderSide(color: PrimeCareColors.slate200),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PrimeCareColors.skyBlue,
          foregroundColor: PrimeCareColors.white,
          minimumSize: const Size(double.infinity, 56),
          elevation: 0,
          padding: PrimeCareSpacing.edgeAllMd,
          shape: RoundedRectangleBorder(
            borderRadius: PrimeCareRadii.boardRounded,
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: PrimeCareColors.radarDark,
          side: const BorderSide(color: PrimeCareColors.slate200, width: 1.5),
          minimumSize: const Size(double.infinity, 56),
          padding: PrimeCareSpacing.edgeAllMd,
          shape: RoundedRectangleBorder(
            borderRadius: PrimeCareRadii.boardRounded,
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: PrimeCareColors.skyBlue,
          padding: PrimeCareSpacing.edgeAllMd,
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: PrimeCareColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: PrimeCareRadii.boardXl),
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: PrimeCareColors.radarDark,
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: PrimeCareColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(PrimeCareRadii.xl.clamp(0.0, 48.0)),
          ),
        ), // safe clamps
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: PrimeCareColors.radarDark,
        contentTextStyle: GoogleFonts.inter(color: PrimeCareColors.white),
        shape: RoundedRectangleBorder(borderRadius: PrimeCareRadii.boardMd),
        behavior: SnackBarBehavior.floating,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: PrimeCareColors.slate200,
        labelStyle: GoogleFonts.inter(
          color: PrimeCareColors.radarDark,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: PrimeCareSpacing.sm,
          vertical: PrimeCareSpacing.xs,
        ),
        shape: RoundedRectangleBorder(borderRadius: PrimeCareRadii.boardPill),
        side: BorderSide.none,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PrimeCareColors.slate200.withAlpha(50),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: PrimeCareRadii.boardRounded,
          borderSide: const BorderSide(color: PrimeCareColors.slate200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: PrimeCareRadii.boardRounded,
          borderSide: const BorderSide(color: PrimeCareColors.slate200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: PrimeCareRadii.boardRounded,
          borderSide: const BorderSide(
            color: PrimeCareColors.skyBlue,
            width: 2.0,
          ),
        ),
        labelStyle: GoogleFonts.inter(color: PrimeCareColors.slate500),
      ),

      dividerTheme: const DividerThemeData(
        color: PrimeCareColors.slate200,
        thickness: 1,
        space: PrimeCareSpacing.xl,
      ),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: PrimeCareTransitionBuilder(),
          TargetPlatform.iOS: PrimeCareTransitionBuilder(),
          TargetPlatform.macOS: PrimeCareTransitionBuilder(),
          TargetPlatform.windows: PrimeCareTransitionBuilder(),
        },
      ),
    );
  }

  // ============== ENTERPRISE DARK THEME ==============
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: PrimeCareColors.radarDark,
      primaryColor: PrimeCareColors.skyBlue,
      colorScheme: const ColorScheme.dark(
        primary: PrimeCareColors.skyBlue,
        secondary: PrimeCareColors.emerald,
        surface: PrimeCareColors.slate800,
        error: PrimeCareColors.rose,
      ),

      textTheme: _buildTextTheme(
        PrimeCareColors.white,
        PrimeCareColors.slate400,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: PrimeCareColors.radarDark,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: PrimeCareColors.white),
        titleTextStyle: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: PrimeCareColors.white,
        ),
      ),

      cardTheme: CardThemeData(
        color: PrimeCareColors.slate800,
        elevation: 0,
        margin: PrimeCareSpacing.edgeAllMd,
        shape: RoundedRectangleBorder(
          borderRadius: PrimeCareRadii.boardLg,
          side: const BorderSide(color: PrimeCareColors.slate700),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PrimeCareColors.skyBlue,
          foregroundColor:
              PrimeCareColors.radarDark, // Deep contrast for cyber aesthetics
          minimumSize: const Size(double.infinity, 56),
          elevation: 0,
          padding: PrimeCareSpacing.edgeAllMd,
          shape: RoundedRectangleBorder(
            borderRadius: PrimeCareRadii.boardRounded,
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: PrimeCareColors.skyBlue,
          side: const BorderSide(color: PrimeCareColors.slate700, width: 1.5),
          minimumSize: const Size(double.infinity, 56),
          padding: PrimeCareSpacing.edgeAllMd,
          shape: RoundedRectangleBorder(
            borderRadius: PrimeCareRadii.boardRounded,
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: PrimeCareColors.slate800,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: PrimeCareRadii.boardXl,
          side: const BorderSide(color: PrimeCareColors.slate700),
        ),
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: PrimeCareColors.white,
        ),
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: PrimeCareColors.slate800,
        elevation: 0,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: PrimeCareColors.slate700,
        labelStyle: GoogleFonts.inter(
          color: PrimeCareColors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: PrimeCareSpacing.sm,
          vertical: PrimeCareSpacing.xs,
        ),
        shape: RoundedRectangleBorder(borderRadius: PrimeCareRadii.boardPill),
        side: BorderSide.none,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PrimeCareColors.slate800,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: PrimeCareRadii.boardRounded,
          borderSide: const BorderSide(color: PrimeCareColors.slate700),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: PrimeCareRadii.boardRounded,
          borderSide: const BorderSide(color: PrimeCareColors.slate700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: PrimeCareRadii.boardRounded,
          borderSide: const BorderSide(
            color: PrimeCareColors.skyBlue,
            width: 2.0,
          ),
        ),
        labelStyle: GoogleFonts.inter(color: PrimeCareColors.slate400),
      ),

      dividerTheme: const DividerThemeData(
        color: PrimeCareColors.slate700,
        thickness: 1,
        space: PrimeCareSpacing.xl,
      ),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: PrimeCareTransitionBuilder(),
          TargetPlatform.iOS: PrimeCareTransitionBuilder(),
          TargetPlatform.macOS: PrimeCareTransitionBuilder(),
          TargetPlatform.windows: PrimeCareTransitionBuilder(),
        },
      ),
    );
  }
}

/// Hardened Theme Data class that provides a unified interface for all tokens.
class PrimeCareThemeData {
  final Brightness brightness;

  PrimeCareThemeData(this.brightness);

  _PrimeCareColors get colors => _PrimeCareColors(brightness);
  _PrimeCareTypography get typography => _PrimeCareTypography(brightness);
  _PrimeCareSpacing get spacing => _PrimeCareSpacing();
  _PrimeCareRadii get radii => _PrimeCareRadii();

  // --- Proxy Getters (Legacy Bridging) ---
  Color get primary => colors.primary;
  Color get secondary => colors.secondary;
  Color get error => colors.error;
  Color get surface => colors.surface;
  Color get outline => colors.borderLight;
  Color get outlineVariant => colors.borderLight;
  Color get primaryContainer => colors.navyIndigo.withValues(alpha: 0.1);
  Color get onPrimaryContainer => colors.navyIndigo;
  Color get onSurfaceVariant => typography._mutedColor;

  TextStyle get headlineMedium => typography.h2;
  TextStyle get bodyMedium => typography.bodyMedium;
  TextStyle get titleMedium => typography.titleMedium;
  TextStyle get labelMedium => typography.labelMedium;
  TextStyle get labelSmall => typography.labelSmall;

  double get radiusMd => radii.md;
  double get radiusLg => radii.lg;
}

class _PrimeCareColors {
  final Brightness brightness;
  _PrimeCareColors(this.brightness);

  bool get isDark => brightness == Brightness.dark;

  // Semantic mappings
  Color get primary => PrimeCareColors.skyBlue;
  Color get secondary => PrimeCareColors.emerald;
  Color get success => PrimeCareColors.emerald;
  Color get error => PrimeCareColors.rose;
  Color get warning => PrimeCareColors.amber;
  Color get coralRed => PrimeCareColors.rose;

  // Specific aliases used in dashboards
  Color get emeraldTeal => PrimeCareColors.emerald;
  Color get azureBlue => PrimeCareColors.skyBlue;
  Color get slateGray => isDark ? PrimeCareColors.slate400 : PrimeCareColors.slate500;
  Color get borderLight => isDark ? PrimeCareColors.slate700 : PrimeCareColors.slate200;
  Color get background => isDark ? PrimeCareColors.radarDark : PrimeCareColors.white;
  Color get surface => isDark ? PrimeCareColors.slate800 : PrimeCareColors.white;

  // Additional aliases found in dashboards
  Color get roseRed => PrimeCareColors.rose;
  Color get amberWarning => PrimeCareColors.amber;
  Color get tealEmerald => PrimeCareColors.emerald;
  Color get navyIndigo => PrimeCareColors.skyBlue; // Primary brand color fallback

  // Raw Slate access for specific visualization components
  Color get slate800 => PrimeCareColors.slate800;
  Color get slate400 => PrimeCareColors.slate400;

  // Surface Containers (M3 Standard)
  Color get surfaceContainerHighest => isDark ? PrimeCareColors.slate600 : PrimeCareColors.slate100;
  Color get surfaceContainerHigh => isDark ? PrimeCareColors.slate700 : PrimeCareColors.slate50;
  Color get surfaceContainerLow => isDark ? PrimeCareColors.slate800 : PrimeCareColors.white;
  Color get surfaceContainerLowest => isDark ? PrimeCareColors.radarDark : PrimeCareColors.white;
}

class _PrimeCareTypography {
  final Brightness brightness;
  _PrimeCareTypography(this.brightness);

  Color get _baseColor => brightness == Brightness.dark ? PrimeCareColors.white : PrimeCareColors.radarDark;
  Color get _mutedColor => brightness == Brightness.dark ? PrimeCareColors.slate400 : PrimeCareColors.slate500;

  TextStyle get h1 => GoogleFonts.plusJakartaSans(fontSize: 32, fontWeight: FontWeight.bold, color: _baseColor);
  TextStyle get h2 => GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.bold, color: _baseColor);
  TextStyle get h3 => GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold, color: _baseColor);
  
  TextStyle get titleLarge => h3;
  TextStyle get titleMedium => GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold, color: _baseColor);
  TextStyle get titleSmall => GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold, color: _baseColor);

  TextStyle get body => bodyMedium;
  TextStyle get bodyBold => GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: _baseColor);
  
  TextStyle get bodyLarge => GoogleFonts.inter(fontSize: 16, color: _baseColor);
  TextStyle get bodyMedium => GoogleFonts.inter(fontSize: 14, color: _baseColor);
  TextStyle get bodySmall => GoogleFonts.inter(fontSize: 12, color: _baseColor);
  
  TextStyle get label => labelMedium;
  TextStyle get labelLarge => GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: _baseColor);
  TextStyle get labelMedium => GoogleFonts.inter(fontSize: 12, color: _mutedColor);
  TextStyle get labelSmall => GoogleFonts.inter(fontSize: 11, color: _mutedColor);
}

class _PrimeCareSpacing {
  double get xxs => PrimeCareSpacing.xxs;
  double get xs => PrimeCareSpacing.xs;
  double get sm => PrimeCareSpacing.sm;
  double get md => PrimeCareSpacing.md;
  double get lg => PrimeCareSpacing.lg;
  double get xl => PrimeCareSpacing.xl;
  double get spacing5 => PrimeCareSpacing.xl; // Legacy bridging
  double get spacing6 => PrimeCareSpacing.xxl; // Legacy bridging
}

class _PrimeCareRadii {
  double get sm => PrimeCareRadii.sm;
  double get md => PrimeCareRadii.md;
  double get lg => PrimeCareRadii.lg;
  double get radiusSm => PrimeCareRadii.sm; // Legacy bridging
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
    return FadeTransition(opacity: animation, child: child);
  }
}

extension PrimeCareThemeContext on BuildContext {
  PrimeCareThemeData get theme => PrimeCareTheme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
}
