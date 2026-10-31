import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_config_generated.dart';
import 'package:primecare_ui/src/theme/prime_fuse_theme.dart';
import 'package:primecare_ui/src/theme/prime_theme.dart';
import 'package:primecare_ui/src/components/prime_components.dart';

void main() {
  test('shared native defaults use generated Fuse palette and profile', () {
    final palette = ThemeConfig.getAppPalette('default');
    final result = PrimeFuseTheme.resolve();
    expect(result.colors.primary, palette.primary);
    expect(result.colors.background, palette.background);
    expect(result.colors.surface, palette.surface);
    expect(result.colors.sidebarBackground, ThemeConfig.getAppPalette('defaultNavbar').background);
    expect(result.colors.topbarBackground, palette.background);
    expect(result.radiusMd, PrimeFuseTheme.defaultProfile.radius.toDouble());
  });
  testWidgets('shared cards inherit the selected surface instead of legacy white', (tester) async {
    final profile = PersonalTheme.fromJson({
      ...PrimeFuseTheme.defaultProfile.toJson(),
      'preset': 'defaultDark',
      'colors': <String, String>{'surface': '#172033', 'background': '#0b1220'},
    });
    final theme = PrimeFuseTheme.resolve(profile: profile);
    await tester.pumpWidget(MaterialApp(
      theme: theme.toThemeData(),
      home: PrimeTheme(data: theme, child: const Scaffold(body: PrimeCareCard(child: Text('Native shared card')))),
    ));
    final card = tester.widget<Card>(find.byType(Card));
    expect(card.color, const Color(0xff172033));
    expect((card.shape! as RoundedRectangleBorder).borderRadius, BorderRadius.circular(profile.radius.toDouble()));
    expect(tester.takeException(), isNull);
  });
  test('unsupported native settings remain rejected', () {
    expect(() => PersonalTheme.fromJson({...PrimeFuseTheme.defaultProfile.toJson(), 'role': 'code_admin'}), throwsFormatException);
  });
}
