import 'package:flutter/material.dart' show Color;
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_config_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'prime_theme.dart';
import 'prime_theme_resolver.dart';

/// Original PrimeCare native adapter for the shared appearance profile.
/// Reuses generated PrimeCare palettes and existing appearance validators.
class PrimeCareTheme {
  const PrimeCareTheme._();

  static String _hex(Color color) => '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';

  static PersonalTheme get defaultProfile => PersonalTheme.fromJson({
    'version': 1,
    'name': 'PrimeCare shared appearance',
    'preset': 'default',
    'fontFamily': 'system',
    'fontScale': 1,
    'radius': 12,
    'colors': <String, String>{
      'sidebar': _hex(ThemeConfig.getAppPalette('defaultNavbar').background),
      'topbar': _hex(ThemeConfig.getAppPalette('default').background),
    },
  });

  static PrimeThemeData resolve({
    PrimeThemeData base = const PrimeThemeData(),
    PersonalTheme? profile,
  }) {
    final appearance = (profile ?? defaultProfile).validated();
    final material = applyPersonalThemeData(base.toThemeData(), appearance);
    return resolvePersonalPrimeTheme(base, material, appearance);
  }
}
