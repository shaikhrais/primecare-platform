import 'package:flutter/material.dart';
import '../theme/prime_theme.dart';
import 'package:flutter_core/theme/theme_contrast.dart';

/// Existing semantic theme roles paired with readable surface and action text.
enum PrimeActionTone { primary, success, warning, error, muted, secondary }

class PrimeActionPalette {
  final Color accent;
  final Color surface;
  final Color border;
  final Color onSurface;
  final Color onAccent;
  final Color onBase;

  PrimeActionPalette._(this.accent, this.surface, Color base, Color candidate)
      : border = accent.withValues(alpha: .3),
        onSurface = readableThemeForeground(surface, accent),
        onAccent = readableThemeForeground(accent, candidate),
        onBase = readableThemeForeground(base, accent);

  /// Pair an existing status/category Color with its actual painted tint.
  static Color tintSurface(BuildContext context, Color accent, {double alpha = .1}) =>
      Color.alphaBlend(accent.withValues(alpha: alpha), context.theme.colors.surface);

  static Color onTint(BuildContext context, Color accent, {double alpha = .1}) =>
      readableThemeForeground(tintSurface(context, accent, alpha: alpha), accent);

  factory PrimeActionPalette.of(BuildContext context, PrimeActionTone tone) {
    final colors = context.theme.colors;
    final (accent, surface) = switch (tone) {
      PrimeActionTone.primary => (colors.primary, colors.primaryContainer),
      PrimeActionTone.secondary => (colors.secondary, colors.secondaryContainer),
      PrimeActionTone.success => (colors.success, colors.successContainer),
      PrimeActionTone.warning => (colors.warning,
          Color.alphaBlend(colors.warningContainer, colors.surface)),
      PrimeActionTone.error => (colors.error, colors.errorContainer),
      PrimeActionTone.muted => (colors.onSurfaceVariant, colors.surfaceContainerHigh),
    };
    return PrimeActionPalette._(accent, surface, colors.surface, colors.onSurface);
  }
}
