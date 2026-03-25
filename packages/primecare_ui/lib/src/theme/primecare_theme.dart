import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'theme_tokens.dart';
import 'theme_extension.dart';

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

  // ============== ENTERPRISE LIGHT THEME ==============
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: PrimeCareColors.white,
      primaryColor: PrimeCareColors.skyBlue,
      colorScheme: const ColorScheme.light(
        primary: PrimeCareColors.skyBlue,
        secondary: PrimeCareColors.emerald,
        surface: PrimeCareColors.white,
        error: PrimeCareColors.rose,
      ),
      extensions: const [PrimeCareThemeExtension.light],
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
      useMaterial3: true,
      scaffoldBackgroundColor: PrimeCareColors.radarDark,
      primaryColor: PrimeCareColors.skyBlue,
      colorScheme: const ColorScheme.dark(
        primary: PrimeCareColors.skyBlue,
        secondary: PrimeCareColors.emerald,
        surface: PrimeCareColors.slate800,
        error: PrimeCareColors.rose,
      ),
      extensions: const [PrimeCareThemeExtension.dark],
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

      bottomSheetTheme: BottomSheetThemeData(
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
