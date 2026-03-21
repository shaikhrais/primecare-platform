import 'package:flutter/material.dart';
import 'colors.dart';

/// Sub-classing ThemeExtension to strictly type PrimeCare Semantic Architecture natively.
/// This acts as a single source of truth for dynamic OS color resolution.
class PrimeCareThemeExtension extends ThemeExtension<PrimeCareThemeExtension> {
  final Color surfaceElevated;
  final Color borderSubtle;
  final Color textMuted;
  final Color successSurface;
  final Color dangerSurface;

  const PrimeCareThemeExtension({
    required this.surfaceElevated,
    required this.borderSubtle,
    required this.textMuted,
    required this.successSurface,
    required this.dangerSurface,
  });

  @override
  ThemeExtension<PrimeCareThemeExtension> copyWith() {
    return this; // Keep immutable for absolute performance
  }

  @override
  PrimeCareThemeExtension lerp(covariant ThemeExtension<PrimeCareThemeExtension>? other, double t) {
    if (other is! PrimeCareThemeExtension) return this;
    return PrimeCareThemeExtension(
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      successSurface: Color.lerp(successSurface, other.successSurface, t)!,
      dangerSurface: Color.lerp(dangerSurface, other.dangerSurface, t)!,
    );
  }

  // ---- ENTERPRISE TIER SEPARATION ----

  /// Pre-configured Native Light Engine
  static const light = PrimeCareThemeExtension(
    surfaceElevated: Colors.white,
    borderSubtle: PrimeCareColors.slate200,
    textMuted: PrimeCareColors.slate500,
    successSurface: Color(0xFFD1FAE5), // Soft Emerald
    dangerSurface: Color(0xFFFFE4E6), // Soft Rose
  );

  /// Pre-configured Native Dark OS Engine
  static const dark = PrimeCareThemeExtension(
    surfaceElevated: PrimeCareColors.slate800,
    borderSubtle: PrimeCareColors.slate700,
    textMuted: PrimeCareColors.slate400,
    successSurface: Color(0x2210B981), // Alpha-calculated Semantic transparency
    dangerSurface: Color(0x22E11D48), // Alpha-calculated Shadow Rose
  );
}

/// Developer Syntax Sugar overriding physical BuildContext natively
extension PrimeCareContextExtension on BuildContext {
  PrimeCareThemeExtension get pTheme => Theme.of(this).extension<PrimeCareThemeExtension>()!;
  
  // Instant Hooks
  Color get surfaceElevated => pTheme.surfaceElevated;
  Color get borderSubtle => pTheme.borderSubtle;
  Color get textMuted => pTheme.textMuted;
  Color get successSurface => pTheme.successSurface;
  Color get dangerSurface => pTheme.dangerSurface;
}
