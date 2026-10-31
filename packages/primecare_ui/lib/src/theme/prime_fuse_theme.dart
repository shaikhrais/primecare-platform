import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'prime_theme.dart';
import 'prime_theme_resolver.dart';

/// Native adapter for the same approved appearance profile used by Fuse web.
/// Reuses generated palettes and validators; no React widgets or vendor login.
class PrimeFuseTheme {
  const PrimeFuseTheme._();

  static PersonalTheme get defaultProfile => PersonalTheme.fromJson({
    'version': 1,
    'name': 'PrimeCare shared appearance',
    'preset': 'default',
    'fontFamily': 'system',
    'fontScale': 1,
    'radius': 12,
    'colors': <String, String>{},
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
