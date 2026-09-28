import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_support/core/routing/app_router.dart';

class GuestAuth extends AuthNotifier {
  @override
  AuthState build() => AuthState(isInitialized: true);
}

void main() {
  testWidgets('support login renders shared form without SSO bridge', (tester) async {
    final container = ProviderContainer(overrides: [
      authProvider.overrideWith(GuestAuth.new),
    ]);
    addTearDown(container.dispose);
    final router = container.read(appRouterProvider);
    addTearDown(router.dispose);
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
    expect(boundary.child, isA<LoginView>());
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
