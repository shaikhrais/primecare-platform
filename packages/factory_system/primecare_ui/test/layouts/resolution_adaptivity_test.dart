import 'package:flutter/material.dart';
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
        MaterialApp(
          home: BaseLayoutShell(
            userRole: 'CEO',
            currentPath: '/',
            child: const Text('Content'),
          ),
        ),
      );

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
        MaterialApp(
          home: BaseLayoutShell(
            userRole: 'CEO',
            currentPath: '/',
            child: const Text('Content'),
          ),
        ),
      );

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
        MaterialApp(
          home: BaseLayoutShell(
            userRole: 'CEO',
            currentPath: '/',
            child: const Text('High Res Content'),
          ),
        ),
      );

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
  });
}
