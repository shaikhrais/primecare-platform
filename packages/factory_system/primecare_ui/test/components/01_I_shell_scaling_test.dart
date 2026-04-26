// Layer: 01_INFRASTRUCTURE
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';

void main() {
  group('Shell Infrastructure Scaling', () {
    testWidgets('GlobalTopBar and Shell Padding scale for Mega Tier', (
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
                  child: Container(color: Colors.blue),
                );
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.pump(); // Sync sync

      // Verify TopBar Height: 56.0 * 3.0 = 168.0
      final appBarFinder = find.byType(AppBar);
      final appBar = tester.widget<AppBar>(appBarFinder);
      expect(appBar.toolbarHeight, 168.0);

      // Verify Global Padding: 24.0 (lg) * 3.0 (scale) = 72.0 horizontal
      final paddingFinder = find.byKey(const Key('shell_content_padding'));

      final paddingWidget = tester.widget<Padding>(paddingFinder);
      expect(paddingWidget.padding, isA<EdgeInsets>());
      expect((paddingWidget.padding as EdgeInsets).left, 72.0);
      expect((paddingWidget.padding as EdgeInsets).top, 48.0); // 16 * 3

      addTearDown(tester.view.resetPhysicalSize);
    });
  });
}
