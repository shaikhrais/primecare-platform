import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/models/screen_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_client/core/routing/app_router.dart';

class GuestAuth extends AuthNotifier {
  @override
  AuthState build() => AuthState(isInitialized: true);
}

class ClientAuth extends AuthNotifier {
  @override
  AuthState build() => AuthState(isInitialized: true, isAuthenticated: true,
    userId: 'client-fixture', tenantId: 'tenant-fixture', token: 'fixture', role: 'client');
}

void main() {
  testWidgets('client module route is managed while family route stays unavailable', (tester) async {
    final container = ProviderContainer(overrides: [authProvider.overrideWith(ClientAuth.new)]);
    addTearDown(container.dispose);
    final router = container.read(appRouterProvider);
    final shell = router.configuration.routes.whereType<ShellRoute>().single;
    final routes = shell.routes.whereType<GoRoute>().toList();
    final route = routes.singleWhere((item) => item.path == ClientRoutes.patientDashboard);
    expect(routes.map((item) => item.path), isNot(contains(ClientRoutes.familyMemberDashboard)));
    late BuildContext context;
    await tester.pumpWidget(MaterialApp(home: Builder(builder: (value) {
      context = value;
      return const SizedBox.shrink();
    })));
    final state = GoRouterState(router.configuration, uri: Uri.parse(route.path),
      matchedLocation: route.path, fullPath: route.path,
      pathParameters: const {}, pageKey: const ValueKey('client-dashboard'));
    final boundary = route.builder!(context, state) as ManagedScreenBoundary;
    expect(boundary.screenId, route.path);
    expect(boundary.manager.lookup(route.path), isNotNull);
  });
  testWidgets('client login renders shared form without SSO bridge', (tester) async {
    final container = ProviderContainer(overrides: [
      authProvider.overrideWith(GuestAuth.new),
    ]);
    addTearDown(container.dispose);
    final router = container.read(appRouterProvider);
    final paths = router.configuration.routes.whereType<GoRoute>().map((route) => route.path);
    expect(paths, containsAll(SharedAuthRoutes.publicPaths));
    final route = router.configuration.routes.whereType<GoRoute>()
        .singleWhere((route) => route.path == CommonRoutes.login);
    late BuildContext context;
    await tester.pumpWidget(MaterialApp(home: Builder(builder: (value) {
      context = value;
      return const SizedBox.shrink();
    })));
    final state = GoRouterState(router.configuration,
      uri: Uri.parse('/login?enable-semantics=true'),
      matchedLocation: '/login',
      fullPath: '/login',
      pathParameters: const {},
      pageKey: const ValueKey('login'),
    );
    final boundary = route.builder!(context, state) as AppShellBoundary;
    final managed = boundary.child as ManagedScreenBoundary;
    expect(managed.screenId, CommonRoutes.login);
    expect(managed.builder(context), isA<LoginView>());
    final legacy = router.configuration.routes.whereType<GoRoute>()
        .singleWhere((route) => route.path == CommonRoutes.ssoRedirect);
    final location = await legacy.redirect!(context, state);
    expect(Uri.parse(location!).path, '/login');
    expect(Uri.parse(location).hasAuthority, isFalse);
  });

  test('return paths remain local and preserve encoded query values', () {
    expect(validateClinicReturnUrl('https://example.test/path'), isNull);
    expect(validateClinicReturnUrl('//example.test/path'), isNull);
    expect(validateClinicReturnUrl('/login'), isNull);
    expect(validateClinicReturnUrl('/auth/callback'), isNull);
    expect(validateClinicReturnUrl('relative/path'), isNull);
    expect(validateClinicReturnUrl('/clinic/care-plan?q=a%26b'),
      '/clinic/care-plan?q=a%26b');
  });
}
