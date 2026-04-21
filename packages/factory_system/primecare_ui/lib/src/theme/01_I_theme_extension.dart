// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:flutter/material.dart';

/// Enterprise Theme Extension for PrimeCare Semantic Tokens.
/// This allows us to access brand-specific colors that aren't part of the standard ColorScheme.
class PrimeCareThemeExtension extends ThemeExtension<PrimeCareThemeExtension> {
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color surface;

  const PrimeCareThemeExtension({
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.surface,
  });

  @override
  ThemeExtension<PrimeCareThemeExtension> copyWith({
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? surface,
  }) {
    return PrimeCareThemeExtension(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      surface: surface ?? this.surface,
    );
  }

  @override
  ThemeExtension<PrimeCareThemeExtension> lerp(
    ThemeExtension<PrimeCareThemeExtension>? other,
    double t,
  ) {
    if (other is! PrimeCareThemeExtension) {
      return this;
    }
    return PrimeCareThemeExtension(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      info: Color.lerp(info, other.info, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
    );
  }

  // --- Static Presets ---

  static const light = PrimeCareThemeExtension(
    success: PrimeCareColors.emerald,
    warning: PrimeCareColors.amber,
    error: PrimeCareColors.rose,
    info: PrimeCareColors.skyBlue,
    surface: PrimeCareColors.white,
  );

  static const dark = PrimeCareThemeExtension(
    success: PrimeCareColors.emerald,
    warning: PrimeCareColors.amber,
    error: PrimeCareColors.rose,
    info: PrimeCareColors.skyBlue,
    surface: PrimeCareColors.slate800,
  );
}
