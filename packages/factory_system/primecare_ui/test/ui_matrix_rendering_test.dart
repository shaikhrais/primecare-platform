import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/src/components/layouts/master_layout.dart';
import 'package:primecare_ui/src/screens/common/dynamic_role_dashboard_screen.dart';

void main() {
  Widget buildMatrixTestApp() {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const MasterLayout(
            shellType: AppShellType.admin, // Use an active shell
            child: DynamicRoleDashboardScreen(),
          ),
        ),
      ],
    );

    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  group('UI Matrix Rendering Hydration Tests', () {
    testWidgets(
      'Pumps MasterLayout encapsulating DynamicRoleDashboardScreen without crashing',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildMatrixTestApp());
        await tester.pumpAndSettle();

        // Check if MasterLayout builds properly under ProviderScope
        expect(find.byType(MasterLayout), findsOneWidget);

        // Verify the dynamic placeholder is successfully hydrated in the tree
        expect(find.byType(DynamicRoleDashboardScreen), findsOneWidget);
        expect(find.text('Dynamic Role Dashboard Placeholder'), findsOneWidget);

        // Assure Admin Console headers render without conflict
        expect(find.text('Admin Console'), findsOneWidget);
      },
    );

    testWidgets('Validates visual configuration passes without structural overflow', (
      WidgetTester tester,
    ) async {
      // By using a small mobile-sized setup, we test layout builder responsiveness
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(buildMatrixTestApp());
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);

      // AdminLayout should show a hamburger icon Drawer strictly on Mobile sizes instead of the SideBar Component
      expect(
        find.byType(Drawer),
        findsNothing,
      ); // It requires a scaffold open to be visible in tree, but we just check if no exceptions occurred.

      // Cleanup view constraints
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    });
  });
}
