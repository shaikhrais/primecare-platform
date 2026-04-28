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
            sidebarWidth: AdaptiveScalingConfig.getSidebarWidth(tier),
            spacingMultiplier: AdaptiveScalingConfig.getSpacingMultiplier(tier),
            totalColumns: AdaptiveScalingConfig.getGridColumns(tier),
            sidebarColumns: AdaptiveScalingConfig.getSidebarSpan(tier),
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
    testWidgets('PageTemplate builds correctly', (tester) async {
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

      final titleFinder = find.text('Institutional Dashboard');
      expect(titleFinder, findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('PrimeStatCard builds with proper icon and text', (
      tester,
    ) async {
      const scale = 2.0; // 4k Tier
      await tester.pumpWidget(
        buildTestableWidget(
          tier: ResolutionTier.fourK,
          scaleFactor: scale,
          child: const PrimeStatCard(
            title: 'Active Patients',
            value: '1,280',
            delta: 12.5,
            icon: Icons.person,
            iconColor: Colors.blue,
          ),
        ),
      );

      final titleFinder = find.text('Active Patients');
      expect(titleFinder, findsOneWidget);

      final valueFinder = find.text('1,280');
      expect(valueFinder, findsOneWidget);
    });

    testWidgets('PrimeCareResponsiveKpiGrid builds correctly', (tester) async {
      tester.view.physicalSize = const Size(7680, 4320);
      tester.view.devicePixelRatio = 1.0;

      final children = List<Widget>.generate(
        12,
        (i) => PrimeStatCard(
          title: 'Stat $i',
          value: '$i',
          icon: Icons.info,
          iconColor: Colors.blue,
        ),
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

      final firstStatCard = find.byType(PrimeStatCard).first;
      expect(firstStatCard, findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });
  });
}
