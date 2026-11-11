import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:primecare_ui/src/components/prime_status.dart';
import 'package:primecare_ui/src/components/prime_trend_label.dart';
import 'package:flutter_core/theme/theme_contrast.dart';
import 'package:primecare_ui/src/components/prime_components.dart';
import 'package:primecare_ui/src/theme/prime_theme.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';
import 'fixtures/api_error_border_fixture.dart';
import 'fixtures/premium_trend_card_fixture.dart';
import 'fixtures/premium_health_panel_fixture.dart';
import 'fixtures/governance_status_metrics_fixture.dart';

void main() {
  testWidgets('shared trend label keeps size and weight while remaining readable on live theme tints', (tester) async {
    Widget host(PrimeColors colors, bool positive, String label) => PrimeTheme(
      data: PrimeThemeData(colors: colors),
      bootstrap: false,
      child: MaterialApp(home: Scaffold(body: PrimeTrendLabel(label, isPositive: positive))),
    );
    for (final colors in [
      const PrimeColors(),
      const PrimeColors(surface: Colors.black, success: Colors.yellow, warning: Colors.pink),
      const PrimeColors(surface: Colors.white, success: Colors.cyan, warning: Colors.yellow),
    ]) {
      for (final positive in [true, false]) {
        final label = positive ? '+4%' : '-2%';
        await tester.pumpWidget(host(colors, positive, label));
        await tester.pumpAndSettle();
        final text = tester.widget<Text>(find.text(label));
        final role = positive ? colors.success : colors.warning;
        final background = Color.alphaBlend(role.withValues(alpha: .1), colors.surface);
        expect(text.style!.fontSize, 11);
        expect(text.style!.fontWeight, FontWeight.bold);
        expect(text.style!.color, readableThemeForeground(background, role));
        expect(themeContrastRatio(text.style!.color!, background), greaterThanOrEqualTo(4.5));
        expect(find.text(label), findsOneWidget);
        expect(tester.takeException(), isNull);
      }
    }
  });

  testWidgets('generated metrics use live success and warning colors and retain values', (tester) async {
    Widget host(PrimeColors colors) => PrimeTheme(
      data: PrimeThemeData(colors: colors),
      bootstrap: false,
      child: MaterialApp(
        home: const Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(width: 500, child: GovernanceStatusMetricsFixture()),
          ),
        ),
      ),
    );
    for (final colors in [const PrimeColors(), const PrimeColors(success: Colors.purple, warning: Colors.cyan)]) {
      await tester.pumpWidget(host(colors));
      await tester.pumpAndSettle();
      final icons = tester.widgetList<Icon>(find.byWidgetPredicate((widget) => widget is Icon && widget.size == 20)).toList();
      expect(icons, hasLength(3));
      expect(icons.take(2).every((icon) => icon.color == colors.success), isTrue);
      expect(icons.last.color, colors.warning);
      expect(find.text('Latency Telemetry'), findsOneWidget);
      expect(find.text('14ms'), findsOneWidget);
      expect(find.text('97%'), findsOneWidget);
      expect(find.text('Operational Status'), findsOneWidget);
      expect(find.text('Active'), findsOneWidget);
      expect(find.text('Security Sync'), findsOneWidget);
      expect(find.text('Clear'), findsOneWidget);
      expect(find.text('92%'), findsOneWidget);
      expect(find.text('100%'), findsOneWidget);
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('generated API health follows live status tokens and keeps labels, typography and progress', (tester) async {
    for (final populated in [false, true]) {
      for (final colors in [const PrimeColors(), const PrimeColors(success: Colors.purple, warning: Colors.cyan)]) {
        final prime = PrimeThemeData(colors: colors);
        await tester.pumpWidget(PrimeTheme(data: prime, bootstrap: false,
          child: MaterialApp(home: Scaffold(body: SingleChildScrollView(child: SizedBox(width: 600,
            child: PremiumHealthPanelFixture(modelName: 'Care', data: populated ? {'id': 1} : {},
              themeColor: Colors.blue)))))));
        await tester.pumpAndSettle();
        final label = populated ? 'Nominal' : 'Offline';
        final text = tester.widget<Text>(find.text(label));
        expect(text.style!.color, populated ? colors.success : colors.warning);
        expect(text.style!.fontWeight, FontWeight.bold);
        expect(text.style!.fontSize, 13);
        expect(find.text('API Response Health'), findsOneWidget);
        expect(find.text('Care Data Drift Monitor'), findsOneWidget);
        final progress = tester.widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator));
        expect(progress.value, populated ? 0.94 : 0.35);
        expect(progress.minHeight, 8);
        expect(progress.valueColor!.value, Colors.blue);
        expect(tester.takeException(), isNull);
      }
    }
  });

  testWidgets('health panel wraps long labels at mobile widths and large text sizes', (tester) async {
    for (final width in [320.0, 600.0]) {
      for (final scale in [1.0, 2.0]) {
        for (final populated in [false, true]) {
          await tester.pumpWidget(PrimeTheme(data: const PrimeThemeData(), bootstrap: false,
            child: MaterialApp(home: MediaQuery(
              data: MediaQueryData(textScaler: TextScaler.linear(scale)),
              child: Scaffold(body: SingleChildScrollView(child: Align(alignment: Alignment.topLeft,
                child: SizedBox(width: width, child: PremiumHealthPanelFixture(
                  modelName: 'Regional community care coordination',
                  data: populated ? {'id': 1} : {}, themeColor: Colors.blue)))))))));
          await tester.pumpAndSettle();
          expect(find.text('Regional community care coordination Data Drift Monitor'), findsOneWidget);
          expect(find.text('Strict Tenant Isolation'), findsOneWidget);
          expect(find.text('API Response Health'), findsOneWidget);
          expect(find.text(populated ? 'Nominal' : 'Offline'), findsOneWidget);
          final progress = tester.widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator));
          expect(progress.value, populated ? .94 : .35);
          expect(progress.minHeight, 8);
          expect(tester.takeException(), isNull, reason: '$width / $scale / $populated');
        }
      }
    }
  });

  testWidgets('generated trend badge follows success and warning tokens without changing labels or geometry', (tester) async {
    for (final positive in [true, false]) {
      for (final colors in [
        const PrimeColors(),
        const PrimeColors(success: Colors.purple, warning: Colors.cyan),
      ]) {
        final prime = PrimeThemeData(colors: colors);
        await tester.pumpWidget(PrimeTheme(data: prime, bootstrap: false,
          child: MaterialApp(home: const Scaffold(body: SizedBox(width: 360,
            child: PremiumTrendCardFixture(title: 'Care visits', value: '42', change: '+4%',
              isPositive: true, icon: Icons.favorite, color: Colors.blue))))));
        // Exercise both ternary branches against a live replacement of the theme.
        await tester.pumpWidget(PrimeTheme(data: prime, bootstrap: false,
          child: MaterialApp(home: Scaffold(body: SizedBox(width: 360,
            child: PremiumTrendCardFixture(title: 'Care visits', value: '42', change: '+4%',
              isPositive: positive, icon: Icons.favorite, color: Colors.blue))))));
        await tester.pumpAndSettle();
        final role = positive ? colors.success : colors.warning;
        final icon = tester.widget<Icon>(find.byWidgetPredicate((widget) =>
          widget is Icon && widget.size == 12));
        expect(icon.icon, positive ? Icons.arrow_upward : Icons.arrow_downward);
        expect(icon.color, role);
        final badge = tester.widgetList<Container>(find.byType(Container)).where((widget) =>
          widget.decoration is BoxDecoration &&
          (widget.decoration! as BoxDecoration).borderRadius == BorderRadius.circular(20) &&
          (widget.decoration! as BoxDecoration).border == null &&
          (widget.decoration! as BoxDecoration).color != null).single;
        expect((badge.decoration! as BoxDecoration).color, role.withOpacity(0.1));
        expect(badge.padding, const EdgeInsets.symmetric(horizontal: 10, vertical: 6));
        expect(find.text('Care visits'), findsOneWidget);
        expect(find.text('42'), findsOneWidget);
        expect(find.text('+4%'), findsOneWidget);
        expect(tester.takeException(), isNull);
      }
    }
  });

  testWidgets('API error panel border changes with theme and keeps retry callback', (tester) async {
    const base = PrimeThemeData();
    var retries = 0;
    for (final preset in themeCenterPresetNames) {
      final profile = PersonalTheme(name: 'Error panel', preset: preset);
      final material = applyPersonalThemeData(base.toThemeData(), profile);
      final prime = resolvePersonalPrimeTheme(base, material, profile);
      await tester.pumpWidget(ProviderScope(child: PrimeTheme(data: prime, child: MaterialApp(theme: material,
        home: Scaffold(body: ApiErrorBorderFixture(onRetry: () { retries++; }))))));
      await tester.pumpAndSettle();
      final panel = tester.widget<Container>(find.byKey(const Key('error-panel')));
      final border = (panel.decoration! as BoxDecoration).border! as Border;
      expect(border.top.color, prime.colors.error, reason: preset);
      expect(border.top.width, 1);
      expect(find.text('Could not load care details'), findsOneWidget);
      final before = retries;
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();
      expect(retries, before + 1, reason: preset);
      expect(tester.takeException(), isNull, reason: preset);
    }
  });

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
            PrimeStatusIcon(Icons.check_circle_outline, tone: PrimeStatusTone.success),
            PrimeStatusIcon(Icons.warning_amber, tone: PrimeStatusTone.warning),
            PrimeStatusIcon(Icons.warning, tone: PrimeStatusTone.error, size: 48),
            PrimeStatusIcon(Icons.inbox, tone: PrimeStatusTone.muted, size: 64),
            PrimeStatusText('Available error message', tone: PrimeStatusTone.error),
          ]),
        )),
      )));
      await tester.pump();
      expect(tester.widget<CircularProgressIndicator>(find.byType(CircularProgressIndicator)).color, prime.colors.primary, reason: preset);
      expect(tester.widget<Icon>(find.byIcon(Icons.check_circle_outline)).color, prime.colors.success, reason: preset);
      expect(tester.widget<Icon>(find.byIcon(Icons.warning_amber)).color, prime.colors.warning, reason: preset);
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
