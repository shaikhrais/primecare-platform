import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';
import 'fixtures/premium_primary_brand_fixture.dart';

void main() {
  testWidgets('four exact premium primary consumers update from the active theme', (tester) async {
    const base = PrimeThemeData();
    final builders = <WidgetBuilder>[primaryBrandConsumer0, primaryBrandConsumer1,
      primaryBrandConsumer2, primaryBrandConsumer3];
    const icons = [Icons.hub, Icons.analytics, Icons.cleaning_services, Icons.lock];
    const sizes = [22.0, 20.0, 16.0, 14.0];
    for (final preset in themeCenterPresetNames) {
      final profile = PersonalTheme(name: 'Primary consumers', preset: preset);
      final material = applyPersonalThemeData(base.toThemeData(), profile);
      final prime = resolvePersonalPrimeTheme(base, material, profile);
      for (var i = 0; i < builders.length; i++) {
        await tester.pumpWidget(PrimeTheme(data: prime, bootstrap: false,
          child: MaterialApp(theme: material, home: Scaffold(body: SingleChildScrollView(
            child: SizedBox(width: 600, child: Builder(builder: builders[i])),
          )))));
        await tester.pumpAndSettle();
        final icon = tester.widget<Icon>(find.byWidgetPredicate((widget) =>
          widget is Icon && widget.icon == icons[i] && widget.size == sizes[i]));
        expect(icon.color, prime.colors.primary, reason: '$preset / $i');
        if (i == 0) {
          expect(find.text('Telemetry Node Health'), findsOneWidget);
          expect(find.text('99.98%'), findsOneWidget);
          expect(find.text('+0.02%'), findsOneWidget);
        } else if (i == 1) {
          final progress = tester.widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator));
          expect(progress.valueColor!.value, prime.colors.primary);
          expect(progress.value, .35);
          expect(progress.minHeight, 8);
          expect(find.text('AppNotification Data Drift Monitor'), findsOneWidget);
        } else if (i == 2) {
          expect(find.text('Purge Buffers'), findsOneWidget);
          await tester.tap(find.text('Purge Buffers'));
          await tester.pumpAndSettle();
        } else {
          expect(find.text('Zero-Trust Audit Log'), findsOneWidget);
          expect(find.text('Verified tenant credentials with secure authentication.'), findsOneWidget);
          expect(find.text('1h ago'), findsOneWidget);
        }
        expect(tester.takeException(), isNull, reason: '$preset / $i');
      }
    }
  });
}
