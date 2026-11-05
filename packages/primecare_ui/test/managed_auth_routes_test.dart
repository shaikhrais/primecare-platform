import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/features/auth/shared_auth_router.dart';
import 'package:flutter_core/models/screen.dart';
import 'package:primecare_ui/src/features/workspace/workspace_routes_generated.dart';
import 'package:primecare_ui/src/features/platform/platform_master_catalog.g.dart';

void main() {
  test('all rendered shared authentication routes have registrations', () {
    for (final path in [
      '/login', '/signup', '/forgot-password', '/reset-password', '/mfa',
      '/language', '/auth/error', '/consent', '/success',
    ]) {
      expect(SharedAuthRoutes.screenManager.lookup(path), isNotNull, reason: path);
    }
  });

  test('generated workspace and special routes have registrations', () {
    expect(SharedAuthRoutes.screenManager.lookup(platformAdministrationRoute), isNotNull);
    expect(SharedAuthRoutes.screenManager.lookup('/maintenance/configuration'), isNotNull);
    for (final paths in governedWorkspaceRoleRoutes.values) {
      for (final path in paths) {
        expect(SharedAuthRoutes.screenManager.lookup(path), isNotNull, reason: path);
      }
    }
  });

  testWidgets('adapter preserves application feature settings', (tester) async {
    ScreenFeatureConfig? observed;
    await tester.pumpWidget(MaterialApp(
      home: ScreenFeatureScope(
        features: const ScreenFeatureConfig(padding: EdgeInsets.all(9)),
        child: SharedAuthRoutes.managedPage('/login', (context) {
          observed = ScreenFeatureScope.of(context);
          return const SizedBox(key: Key('managed-auth-child'));
        }),
      ),
    ));
    expect(find.byKey(const Key('managed-auth-child')), findsOneWidget);
    expect(observed!.padding, const EdgeInsets.all(9));
  });
}
