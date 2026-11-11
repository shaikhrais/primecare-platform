import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:primecare_ui/src/components/prime_status.dart';
import 'package:primecare_ui/src/components/prime_components.dart';
import 'package:primecare_ui/src/theme/prime_theme.dart';

void main() {
  testWidgets('status controls resolve every palette and retain inherited typography', (tester) async {
    const base = PrimeThemeData();
    for (final preset in themeCenterPresetNames) {
      final profile = PersonalTheme(name: 'Status controls', preset: preset, fontScale: 1.5);
      final material = applyPersonalThemeData(base.toThemeData(), profile);
      final prime = resolvePersonalPrimeTheme(base, material, profile);
      await tester.pumpWidget(PrimeTheme(data: prime, child: MaterialApp(theme: material,
        home: const Scaffold(body: DefaultTextStyle(
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
          child: Column(children: [
            DashboardLoadingWidget(),
            PrimeStatusIcon(Icons.warning, tone: PrimeStatusTone.error, size: 48),
            PrimeStatusIcon(Icons.inbox, tone: PrimeStatusTone.muted, size: 64),
            PrimeStatusText('Available error message', tone: PrimeStatusTone.error),
          ]),
        )),
      )));
      await tester.pump();
      expect(tester.widget<CircularProgressIndicator>(find.byType(CircularProgressIndicator)).color, prime.colors.primary, reason: preset);
      final error = tester.widget<Icon>(find.byIcon(Icons.warning));
      final empty = tester.widget<Icon>(find.byIcon(Icons.inbox));
      expect(error.color, prime.colors.error, reason: preset);
      expect(error.size, 48);
      expect(empty.color, prime.colors.onSurfaceVariant, reason: preset);
      expect(empty.size, 64);
      final rendered = tester.widget<RichText>(find.descendant(
        of: find.byType(PrimeStatusText), matching: find.byType(RichText)));
      expect(rendered.text.style!.color, prime.colors.error, reason: preset);
      expect(rendered.text.style!.fontSize, 21, reason: preset);
      expect(rendered.text.style!.fontWeight, FontWeight.w600, reason: preset);
      expect(tester.takeException(), isNull, reason: preset);
    }
  });
}
