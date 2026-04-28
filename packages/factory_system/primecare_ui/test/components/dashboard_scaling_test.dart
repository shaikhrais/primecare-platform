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

    testWidgets('DynamicScreenAdapter hydrates registry UI properly', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Consumer(
                builder: (context, ref, _) {
                  final adapter = ref.watch(
                    dynamicAdapterProvider(PrimeCareForm.ceoDashboard),
                  );
                  final data = adapter.watchData();

                  return data.when(
                    data: (result) {
                      if (result is Success<PrimeCareDashboardViewModel>) {
                        return Text(
                          'Hydrated: ${result.data.isOfflineFallback}',
                        );
                      }
                      return const Text('Hydration Failed');
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (err, stack) => Text('Fatal Error: $err'),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // Should find the 'Hydrated:' text, indicating the dynamic adapter successfully resolved
      // the CeoDashboard registry data (even if fallback).
      expect(find.textContaining('Hydrated:'), findsOneWidget);
    });

    testWidgets('Responsive KpiGrid scales down gracefully to Mobile tier', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(
        390,
        844,
      ); // iPhone 12/13/14 portrait
      tester.view.devicePixelRatio = 3.0;

      final children = List<Widget>.generate(
        4,
        (i) => PrimeStatCard(
          title: 'Mobile Stat $i',
          value: '$i',
          icon: Icons.smartphone,
          iconColor: Colors.blue,
        ),
      );

      await tester.pumpWidget(
        buildTestableWidget(
          tier: ResolutionTier.mob,
          scaleFactor: 1.0,
          child: SizedBox(
            width: 390,
            child: PrimeCareResponsiveKpiGrid(children: children),
          ),
        ),
      );

      final firstStatCard = find.byType(PrimeStatCard).first;
      expect(firstStatCard, findsOneWidget);
      expect(find.text('Mobile Stat 0'), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    });

    testWidgets('Full Structure Widget Diagnostics Snapshot (Instant UI Test)', (
      tester,
    ) async {
      // Build a complex UI structure
      final children = List<Widget>.generate(
        4,
        (i) => PrimeStatCard(
          title: 'Snapshot Stat $i',
          value: '$i',
          icon: Icons.data_usage,
          iconColor: Colors.blue,
        ),
      );

      await tester.pumpWidget(
        buildTestableWidget(
          tier: ResolutionTier.fourK,
          scaleFactor: 1.0,
          child: SizedBox(
            width: 1200,
            child: PrimeCareResponsiveKpiGrid(children: children),
          ),
        ),
      );

      // 1. Capture the EXACT structural layout instantly (bypasses visual rendering)
      final treeStructure = tester.binding.rootElement!.toStringDeep();

      // We print it so you can see what it captures in the test output
      debugPrint('==== FULL WIDGET STRUCTURE SNAPSHOT ====');
      debugPrint(treeStructure);

      // 2. We can assert the full structure is intact without searching element-by-element
      expect(treeStructure, isNotEmpty);
      expect(treeStructure.contains('PrimeCareResponsiveKpiGrid'), isTrue);
      expect(treeStructure.contains('PrimeStatCard'), isTrue);

      // In a real environment, you save `treeStructure` to a .txt file and do:
      // expect(treeStructure, matchesReferenceStructure('my_dashboard_snapshot.txt'));
    });
  });
}
