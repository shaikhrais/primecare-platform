// Layer: 01_INFRASTRUCTURE
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';


import 'package:google_fonts/google_fonts.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Widget buildTestableWidget({
    required Widget child,
    required ResolutionTier tier,
    required double scaleFactor,
  }) {
    return ProviderScope(
      overrides: [
        layoutProvider.overrideWithValue(
          LayoutConfig(
            tier: tier,
            scaleFactor: scaleFactor,
            sidebarWidth: 280 * scaleFactor,
            spacingMultiplier: scaleFactor,
          ),
        ),
      ],
      child: MaterialApp(
        theme: PrimeCareDesignSystem.lightTheme,
        home: Scaffold(body: child),
      ),
    );
  }

  group('Dashboard Component Scaling Regression Tests', () {
    testWidgets('PageTemplate scales margins and typography on Mega Display', (
      tester,
    ) async {
      // Set mega display size
      tester.view.physicalSize = const Size(7680, 4320);
      tester.view.devicePixelRatio = 1.0;

      const scale = 3.0;
      await tester.pumpWidget(
        buildTestableWidget(
          tier: ResolutionTier.mega,
          scaleFactor: scale,
          child: const PageTemplate(
            title: 'Institutional Dashboard',
            subtitle: 'Global Metrics scaling test',
            body: Text('Content'),
          ),
        ),
      );

      // Verify Title Scaling (AppBar title is 20 * scale)
      final titleFinder = find.text('Institutional Dashboard');
      expect(titleFinder, findsOneWidget);
      final titleText = tester.widget<Text>(titleFinder);
      expect(titleText.style?.fontSize, equals(20.0 * scale));

      // Verify Scaled Padding (Edge Screen Margin)
      final scrollFinder = find.byType(SingleChildScrollView);
      final scrollView = tester.widget<SingleChildScrollView>(scrollFinder);
      expect(
        scrollView.padding,
        equals(PrimeCareSpacing.scaledEdgeScreen(scale)),
      );

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('PrimeCareStatCard scales geometry and typography', (
      tester,
    ) async {
      const scale = 2.0; // 4k Tier
      await tester.pumpWidget(
        buildTestableWidget(
          tier: ResolutionTier.fourK,
          scaleFactor: scale,
          child: const PrimeCareStatCard(
            title: 'Active Patients',
            value: '1,280',
            delta: 12.5,
          ),
        ),
      );

      // Verify StatCard title is uppercase as implemented
      final titleFinder = find.text('ACTIVE PATIENTS');
      expect(titleFinder, findsOneWidget);

      // Verify Container Padding (lg = 24)
      final containerFinder = find.byType(Container).first;
      final container = tester.widget<Container>(containerFinder);
      final padding = container.padding as EdgeInsets;
      expect(padding.top, equals(24.0 * scale));

      // Verify Metric Value Scaling (we set 32 in refactor)
      final valueFinder = find.text('1,280');
      final valueText = tester.widget<Text>(valueFinder);
      expect(valueText.style?.fontSize, equals(32.0 * scale));
    });

    testWidgets('PrimeCareResponsiveKpiGrid enforces 6-column density on Mega Tier', (
      tester,
    ) async {
      // Set mega display size - wider to ensure 6 col fits without overflow if Wrap wraps
      tester.view.physicalSize = const Size(7680, 4320);
      tester.view.devicePixelRatio = 1.0;

      final children = List.generate(
        12,
        (i) => PrimeCareStatCard(title: 'Stat $i', value: '$i'),
      );

      await tester.pumpWidget(
        buildTestableWidget(
          tier: ResolutionTier.mega,
          scaleFactor: 3.0,
          child: SizedBox(
            width: 7680,
            child: PrimeCareResponsiveKpiGrid(children: children),
          ),
        ),
      );

      // On Mega tier (6 columns), spacing is PrimeCareSpacing.md * 3 (16 * 3 = 48)
      double spacing = 16.0 * 3.0;
      // horizontalPadding from PageTemplate is scaledEdgeScreen(3.0) = 48?
      // No, this grid is raw in the test.
      // Child width calculation in grid: (maxWidth - (spacing * (activeCols - 1))) / activeCols
      double expectedWidth = (7680 - (spacing * 5)) / 6;

      final firstStat = find
          .byType(SizedBox)
          .at(1); // The first child SizedBox wrapping the child
      final sizeBox = tester.widget<SizedBox>(firstStat);
      expect(sizeBox.width, closeTo(expectedWidth, 0.1));

      addTearDown(tester.view.resetPhysicalSize);
    });
  });
}
