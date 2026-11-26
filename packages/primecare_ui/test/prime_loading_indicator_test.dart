import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:primecare_ui/src/components/prime_loading_indicator.dart';
import 'package:primecare_ui/src/theme/prime_theme.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';

void main() {
  testWidgets('const indicator follows inherited palette changes', (tester) async {
    const base = PrimeThemeData();
    for (final preset in themeCenterPresetNames) {
      final profile = PersonalTheme(name: 'Loading', preset: preset);
      final material = applyPersonalThemeData(base.toThemeData(), profile);
      final theme = resolvePersonalPrimeTheme(base, material, profile);
      await tester.pumpWidget(PrimeTheme(data: theme,
        child: MaterialApp(theme: material, home: const Scaffold(
          body: Center(child: PrimeLoadingIndicator(key: Key('loading'))),
        )),
      ));
      await tester.pump();
      final indicator = tester.widget<CircularProgressIndicator>(find.byType(CircularProgressIndicator));
      expect(indicator.color, theme.colors.primary, reason: preset);
      expect(indicator.value, isNull);
      expect(find.byKey(const Key('loading')), findsOneWidget);
      expect(tester.takeException(), isNull, reason: preset);
    }
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
