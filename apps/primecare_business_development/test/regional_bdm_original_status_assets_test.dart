import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/original_assets.dart';
import 'package:primecare_ui/primecare_ui.dart'
    show DashboardLoadingWidget, PrimeStatusIcon, PrimeStatusTone;
import 'package:primecare_business_development/features/bdm/screens/regional_bdm_competitor_notes_screen.dart';
import 'package:primecare_business_development/features/bdm/screens/regional_bdm_competitor_notes_screen_controller.dart';
import 'package:primecare_business_development/features/bdm/screens/regional_bdm_dashboard_screen.dart';
import 'package:primecare_business_development/features/bdm/screens/regional_bdm_dashboard_screen_controller.dart';

// These overrides replace the non-executable scaffold state. They never call a
// network/provider service and do not claim business-feature implementation.
class _CompetitorState extends RegionalBdmCompetitorNotesScreenController {
  _CompetitorState(this.value);
  final AsyncValue<Map<String, dynamic>> value;

  @override
  AsyncValue<Map<String, dynamic>> build() => value;
}

class _DashboardState extends RegionalBdmDashboardScreenController {
  _DashboardState(this.value);
  final AsyncValue<Map<String, dynamic>> value;

  @override
  AsyncValue<Map<String, dynamic>> build() => value;
}

Widget _host(
  Widget screen,
  AsyncValue<Map<String, dynamic>> value, {
  PrimeColors colors = const PrimeColors(),
  TextDirection direction = TextDirection.ltr,
}) => ProviderScope(
  overrides: [
    regionalBdmCompetitorNotesScreenControllerProvider.overrideWith(
      () => _CompetitorState(value),
    ),
    regionalBdmDashboardScreenControllerProvider.overrideWith(
      () => _DashboardState(value),
    ),
  ],
  child: PrimeTheme(
    data: PrimeThemeData(colors: colors),
    bootstrap: false,
    child: MaterialApp(
      home: Directionality(
        textDirection: direction,
        child: IconTheme(
          data: const IconThemeData(size: 20, opacity: .4),
          child: screen,
        ),
      ),
    ),
  ),
);

void main() {
  final screens = <String, Widget>{
    'competitor notes': const RegionalBdmCompetitorNotesScreen(),
    'dashboard': const RegionalBdmDashboardScreen(),
  };

  for (final entry in screens.entries) {
    testWidgets('${entry.key} uses the registered original success asset', (tester) async {
      for (final colors in [
        const PrimeColors(),
        const PrimeColors(success: Colors.purple),
      ]) {
        for (final direction in TextDirection.values) {
          await tester.pumpWidget(_host(
            entry.value,
            const AsyncValue.data(<String, dynamic>{'fixture': true}),
            colors: colors,
            direction: direction,
          ));
          await tester.pumpAndSettle();
          final status = tester.widget<PrimeStatusIcon>(find.byType(PrimeStatusIcon));
          expect(status.icon, Icons.check_circle_outline);
          expect(status.tone, PrimeStatusTone.success);
          expect(status.size, 64);
          expect(status.assetName, 'check');
          expect(status.semanticLabel, isNull);
          final assetFinder = find.descendant(
            of: find.byType(PrimeStatusIcon),
            matching: find.byType(PrimeOriginalAsset),
          );
          final asset = tester.widget<PrimeOriginalAsset>(assetFinder);
          expect(resolveOriginalAsset(asset.name), 'check');
          expect(originalAssetInfo(asset.name)['category'], 'icon');
          expect(asset.color, colors.success);
          expect(asset.decorative, isTrue);
          expect(asset.semanticLabel, isNull);
          expect(IconTheme.of(tester.element(assetFinder)).opacity, .4);
          expect(find.descendant(of: assetFinder, matching: find.byType(ExcludeSemantics)), findsOneWidget);
          final drawing = find.descendant(of: assetFinder, matching: find.byType(CustomPaint));
          expect(tester.getSize(drawing), const Size(64, 64));
          expect(tester.widget<CustomPaint>(drawing).painter, isNotNull);
          expect(find.byIcon(Icons.check_circle_outline), findsNothing);
          expect(tester.takeException(), isNull);
          await tester.pumpWidget(const SizedBox.shrink());
        }
      }
    });

    testWidgets('${entry.key} retains the shared loading branch', (tester) async {
      await tester.pumpWidget(_host(entry.value, const AsyncValue.loading()));
      await tester.pump();
      expect(find.byType(DashboardLoadingWidget), findsOneWidget);
      expect(find.byType(PrimeStatusIcon), findsNothing);
      expect(find.byType(PrimeOriginalAsset), findsNothing);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    });

    testWidgets('${entry.key} retains the existing error branch', (tester) async {
      await tester.pumpWidget(_host(
        entry.value,
        AsyncValue.error(StateError('fixture failure'), StackTrace.current),
      ));
      await tester.pumpAndSettle();
      expect(find.text('Error loading features: Bad state: fixture failure'), findsOneWidget);
      expect(find.byType(PrimeStatusIcon), findsNothing);
      expect(find.byType(PrimeOriginalAsset), findsNothing);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }
}
