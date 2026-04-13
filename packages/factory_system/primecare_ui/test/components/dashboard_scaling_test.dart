import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_core/providers/portal_providers.dart';

void main() {
  group('Dashboard Components Scaling', () {
    testWidgets('StatCard scales dimensions based on LayoutProvider', (
      WidgetTester tester,
    ) async {
      // 1. Setup Mega Display (Scale 3.0)
      tester.view.physicalSize = const Size(5120, 2880);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            screenMetricsProvider.overrideWith(ScreenMetricsNotifier.new),
          ],
          child: MaterialApp(
            home: Consumer(
              builder: (context, ref, child) {
                // Initialize the metrics immediately
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref
                      .read(screenMetricsProvider.notifier)
                      .state = const MediaQueryData(
                    size: Size(5120, 2880),
                    devicePixelRatio: 1.0,
                  );
                });

                return BaseLayoutShell(
                  currentPath: '/',
                  child: Consumer(
                    builder: (context, ref, child) {
                      final layout = ref.watch(layoutProvider);
                      debugPrint('Layout Tier: ${layout.tier}');
                      debugPrint('Scale Factor: ${layout.scaleFactor}');
                      return PrimeCareStatCard(
                        title: 'Revenue',
                        value: '\$12,500',
                        delta: 12.5,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.pump(); // Second pump to capture metrics sync

      // Find the card container specifically within PrimeCareStatCard
      final containerFinder = find
          .descendant(
            of: find.byType(PrimeCareStatCard),
            matching: find.byType(Container),
          )
          .first;
      final container = tester.widget<Container>(containerFinder);

      // Expected padding: 24.0 (lg) * 3.0 (mega scale) = 72.0
      expect(container.padding, isA<EdgeInsets>());
      expect((container.padding as EdgeInsets).top, 72.0);

      // Verify Title font size scaling (Standard bodyMedium 14 * 3.0 = 42)
      final titleText = tester.widget<Text>(find.text('Revenue'));
      expect(titleText.style?.fontSize, 42.0);

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('KPI Grid increases columns for Mega Tier', (
      WidgetTester tester,
    ) async {
      // Setup Mega Display (Scale 3.0)
      tester.view.physicalSize = const Size(5120, 2880);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            screenMetricsProvider.overrideWith(ScreenMetricsNotifier.new),
          ],
          child: MaterialApp(
            home: Consumer(
              builder: (context, ref, child) {
                // Initialize the metrics immediately
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref
                      .read(screenMetricsProvider.notifier)
                      .state = const MediaQueryData(
                    size: Size(5120, 2880),
                    devicePixelRatio: 1.0,
                  );
                });
                return BaseLayoutShell(
                  currentPath: '/',
                  child: PrimeCareResponsiveKpiGrid(
                    children: List.generate(10, (i) => Text('Card $i')),
                  ),
                );
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.pump(); // Second pump for layout sync

      // Find the sized box specifically within the grid
      final firstCardFinder = find
          .descendant(
            of: find.byType(PrimeCareResponsiveKpiGrid),
            matching: find.byType(SizedBox),
          )
          .first;
      final firstCardBase = tester.widget<SizedBox>(firstCardFinder);

      // Verify width is roughly 1/6th of available space
      // Logic: (maxWidth - 5 * spacing) / 6
      final spacing = 16.0 * 3.0; // md * mega scale
      final gridWidth = tester
          .getSize(find.byType(PrimeCareResponsiveKpiGrid))
          .width;
      final expectedWidth = (gridWidth - (5 * spacing)) / 6;

      expect(firstCardBase.width, isNotNull);
      expect(firstCardBase.width!, closeTo(expectedWidth, 0.1));

      addTearDown(tester.view.resetPhysicalSize);
    });
  });
}
