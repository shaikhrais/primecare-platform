import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/theme_contrast.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';
import 'fixtures/premium_audit_panel_fixture.dart';

void main() {
  testWidgets('actual audit panel shares affirmative badge theme and wraps without losing labels', (tester) async {
    const base = PrimeThemeData();
    for (final preset in themeCenterPresetNames) {
      final profile = PersonalTheme(name: 'Audit panel', preset: preset);
      final material = applyPersonalThemeData(base.toThemeData(), profile);
      final prime = resolvePersonalPrimeTheme(base, material, profile);
      for (final width in [320.0, 800.0]) {
        await tester.pumpWidget(PrimeTheme(data: prime, bootstrap: false,
          child: MaterialApp(theme: material, home: Scaffold(body: MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(2)),
            child: SingleChildScrollView(child: Align(alignment: Alignment.topLeft,
              child: SizedBox(width: width, child: const PremiumAuditPanelFixture(
                modelName: 'Regional community care coordination', themeColor: Colors.blue)))),
          )))));
        await tester.pumpAndSettle();
        expect(find.text('Regional community care coordination Audit Ledger'), findsOneWidget);
        expect(find.byType(Wrap), findsOneWidget);
        for (final label in ['HIPAA Compliant', 'GDPR Verified', 'TLS 1.3 Active']) {
          final badge = find.byWidgetPredicate((widget) => widget is PrimeStatusBadge && widget.label == label);
          expect(badge, findsOneWidget);
          final panel = tester.widget<Container>(find.descendant(of: badge, matching: find.byType(Container)));
          final decoration = panel.decoration! as BoxDecoration;
          final tint = prime.colors.success.withValues(alpha: .08);
          final background = Color.alphaBlend(tint, prime.colors.surface);
          expect(decoration.color, tint, reason: preset);
          expect((decoration.border! as Border).top.color, prime.colors.success.withValues(alpha: .15));
          final text = tester.widget<Text>(find.descendant(of: badge, matching: find.byType(Text)));
          expect(text.data, label);
          expect(text.style!.fontSize, 10.5);
          expect(text.style!.fontWeight, FontWeight.bold);
          expect(themeContrastRatio(text.style!.color!, background), greaterThanOrEqualTo(4.5), reason: preset);
        }
        expect(find.text('Verified UUID Entity'), findsOneWidget);
        expect(find.text('AES-256 GCM'), findsOneWidget);
        expect(find.text('SHA-256 HMAC'), findsOneWidget);
        expect(tester.takeException(), isNull, reason: '$preset / $width');
      }
    }
  });
}
