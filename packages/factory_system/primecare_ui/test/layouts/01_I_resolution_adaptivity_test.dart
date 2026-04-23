// Layer: 01_INFRASTRUCTURE
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';

void main() {
  group('Resolution Adaptivity Matrix', () {
    testWidgets('Mob Tier (<600) - Verifies BottomNavigationBar', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: BaseLayoutShell(currentPath: '/', child: const Text('Content')),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.byType(NavigationRail), findsNothing);

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('Tab Tier (1024) - Verifies Compact Rail', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: BaseLayoutShell(currentPath: '/', child: const Text('Content')),
          ),
        ),
      );
      await tester.pump();

      final railFinder = find.byType(NavigationRail);
      expect(railFinder, findsOneWidget);

      final rail = tester.widget<NavigationRail>(railFinder);
      expect(rail.extended, isFalse);

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('4k Tier (3840) - Verifies Extended Sidebar & Scaling', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(3840, 2160);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: BaseLayoutShell(
              currentPath: '/',
              child: const Text('High Res Content'),
            ),
          ),
        ),
      );

      await tester.pump(); // Synchronize layout state

      // Verify extended sidebar
      final railFinder = find.byType(NavigationRail);
      expect(railFinder, findsOneWidget);
      final rail = tester.widget<NavigationRail>(railFinder);
      expect(rail.extended, isTrue);

      // Verify scaling factor via TextScaler
      final textWidget = tester.element(find.text('High Res Content'));
      final mediaQuery = MediaQuery.of(textWidget);
      expect(mediaQuery.textScaler.scale(10), 15.0); // 1.5x scaling for 4k

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('Mega Tier (5120) - Verifies Extreme Scaling & Mega Sidebar', (
      WidgetTester tester,
    ) async {
      // Threshold: width >= 5120 OR (width >= 3840 AND DPR >= 3.0)
      tester.view.physicalSize = const Size(5120, 2160);
      tester.view.devicePixelRatio = 1.0; // Logical width 5120

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: BaseLayoutShell(
              currentPath: '/',
              child: const Text('Mega Content'),
            ),
          ),
        ),
      );

      await tester.pump(); // Synchronize layout state

      await tester.pumpAndSettle();

      final textWidget = tester.element(find.text('Mega Content'));
      final mediaQuery = MediaQuery.of(textWidget);
      expect(mediaQuery.textScaler.scale(10), 30.0);

      final railFinder = find.byType(NavigationRail);
      expect(railFinder, findsOneWidget);
      final rail = tester.widget<NavigationRail>(railFinder);
      expect(rail.minExtendedWidth, 480.0);

      // Verify scaled AppBar height (56.0 * 3.0 + 1.0 = 169.0)
      final appBarFinder = find.byType(AppBar);
      expect(appBarFinder, findsOneWidget);
      final appBar = tester.widget<AppBar>(appBarFinder);
      expect(appBar.toolbarHeight, 56.0 * 3.0);

      addTearDown(tester.view.resetPhysicalSize);
    });

    group('Navigation Actions Visibility', () {
      testWidgets('Top bar actions are rendered in shell', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: BaseLayoutShell(
              currentPath: '/',
              topBarActions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  key: const Key('action_add'),
                ),
              ],
              child: const Text('Content'),
            ),
          ),
        ),
        );
        expect(find.byKey(const Key('action_add')), findsOneWidget);
      });
    });
  });
}
