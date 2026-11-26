import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/theme_contrast.dart';

void main() {
  test('gradient keeps a mid-tone readable foreground above the contrast threshold', () {
    const foreground = Color(0xff777777);
    for (final stop in readableThemeGradient(Colors.black, foreground)) {
      expect(themeContrastRatio(stop, foreground), greaterThanOrEqualTo(4.5));
    }
  });
  test('all palettes replace legacy filled inputs and retain readable gradients', () {
    final branding = ThemeData(
      cardTheme: const CardThemeData(color: Colors.white, elevation: 7),
      inputDecorationTheme: const InputDecorationTheme(filled: true, fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4)))),
    );
    for (final preset in themeCenterPresetNames) {
      final personal = PersonalTheme(name: 'Test', preset: preset, fontScale: 1.5, radius: 20).validated();
      final theme = applyPersonalThemeData(branding, personal);
      expect(theme.inputDecorationTheme.fillColor, theme.colorScheme.surface, reason: preset);
      expect(theme.cardTheme.color, theme.colorScheme.surface, reason: preset);
      expect(theme.cardTheme.elevation, 0);
      expect(theme.cardTheme.surfaceTintColor, Colors.transparent);
      expect((theme.cardTheme.shape! as RoundedRectangleBorder).side.color, theme.colorScheme.outline);
      final border = theme.inputDecorationTheme.enabledBorder! as OutlineInputBorder;
      expect(border.borderRadius, BorderRadius.circular(20));
      expect(themeContrastRatio(theme.colorScheme.surface, theme.colorScheme.onSurface), greaterThanOrEqualTo(4.5));
      for (final stop in readableThemeGradient(theme.colorScheme.primary, theme.colorScheme.onPrimary)) {
        expect(themeContrastRatio(stop, theme.colorScheme.onPrimary), greaterThanOrEqualTo(4.5), reason: preset);
      }
    }
  });
}
