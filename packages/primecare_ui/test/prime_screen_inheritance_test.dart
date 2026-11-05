import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/models/screen_features.dart';
import 'package:primecare_ui/src/theme/prime_theme.dart';
import 'package:primecare_ui/src/theme/prime_screen_inheritance.dart';

void main() {
  testWidgets('manager follows scoped PrimeCare theme, locale and screen configuration', (tester) async {
    PrimeScreenInheritanceManager? current;
    Widget app(double radius, Locale locale, double padding) => PrimeTheme(
      data: PrimeThemeData(radiusMd: radius),
      child: MaterialApp(
        locale: locale,
        supportedLocales: const [Locale('en', 'US'), Locale('en', 'CA')],
        home: ScreenFeatureScope(
          features: ScreenFeatureConfig(padding: EdgeInsets.all(padding)),
          child: Builder(builder: (context) { current = context.primeScreenInheritance; return const SizedBox(); }),
        ),
      ),
    );
    await tester.pumpWidget(app(9, const Locale('en', 'US'), 4));
    expect(current!.primeTheme.radiusMd, 9);
    expect(current!.locale, const Locale('en', 'US'));
    expect(current!.features.padding, const EdgeInsets.all(4));
    await tester.pumpWidget(app(17, const Locale('en', 'CA'), 8));
    expect(current!.primeTheme.radiusMd, 17);
    expect(current!.locale, const Locale('en', 'CA'));
    expect(current!.features.padding, const EdgeInsets.all(8));
  });
}
