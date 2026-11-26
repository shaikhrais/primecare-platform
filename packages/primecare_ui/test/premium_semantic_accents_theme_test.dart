import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';
import 'fixtures/premium_semantic_accents_fixture.dart';

void main() {
  testWidgets('nine exact premium accents follow active semantic tokens', (tester) async {
    const base = PrimeThemeData();
    final builders = <WidgetBuilder>[
      semanticAccentConsumer0, semanticAccentConsumer1, semanticAccentConsumer2,
      semanticAccentConsumer3, semanticAccentConsumer4, semanticAccentConsumer5,
      semanticAccentConsumer6, semanticAccentConsumer7, semanticAccentConsumer8,
    ];
    const icons = [
      Icons.speed, Icons.cloud_download, Icons.gavel, Icons.gavel,
      Icons.shield, Icons.sync, Icons.download, Icons.cloud_done, Icons.play_arrow,
    ];
    const sizes = [22.0, 22.0, 22.0, 20.0, 16.0, 16.0, 16.0, 14.0, 14.0];
    const roles = ['primary', 'success', 'warning', 'warning', 'primary',
      'success', 'warning', 'success', 'primary'];
    const labels = ['API Request Latency', 'Data Ingestion Rate',
      'Governance Violations', 'AppNotification Audit Ledger', 'Trigger Audit',
      'Sync Schema', 'Export Logs', 'Prisma Client Hydration',
      'Telemetry Session Start'];
    for (final preset in themeCenterPresetNames) {
      final profile = PersonalTheme(name: 'Semantic accents', preset: preset);
      final material = applyPersonalThemeData(base.toThemeData(), profile);
      final prime = resolvePersonalPrimeTheme(base, material, profile);
      final expected = <String, Color>{
        'primary': prime.colors.primary,
        'success': prime.colors.success,
        'warning': prime.colors.warning,
      };
      for (var i = 0; i < builders.length; i++) {
        await tester.pumpWidget(PrimeTheme(
          data: prime,
          bootstrap: false,
          child: MaterialApp(
            theme: material,
            home: Scaffold(body: SingleChildScrollView(
              child: SizedBox(width: 600, child: Builder(builder: builders[i])),
            )),
          ),
        ));
        await tester.pumpAndSettle();
        final icon = tester.widget<Icon>(find.byWidgetPredicate((widget) =>
          widget is Icon && widget.icon == icons[i] && widget.size == sizes[i]));
        expect(icon.color, expected[roles[i]], reason: '$preset / ${labels[i]}');
        expect(find.text(labels[i]), findsOneWidget);
        if (i >= 4 && i <= 6) {
          await tester.tap(find.text(labels[i]));
          await tester.pumpAndSettle();
        }
        expect(tester.takeException(), isNull, reason: '$preset / ${labels[i]}');
      }
    }
  });
}
