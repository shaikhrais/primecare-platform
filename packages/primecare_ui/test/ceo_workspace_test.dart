import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/src/features/generated_screens/ceo_dashboard.dart';
import 'auth_design_test.dart' show localized;

class CeoAuthFixture extends AuthNotifier {
  @override
  AuthState build() => AuthState(isInitialized: true, isAuthenticated: true,
    role: 'ceo', userName: 'ceo@example.test', token: 'test-token');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });
  for (final language in ['en', 'fr', 'es']) {
    testWidgets('CEO account link works at mobile width in $language', (tester) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final router = GoRouter(routes: [
        GoRoute(path: '/', builder: (_, __) => const CeoDashboardScreen()),
        GoRoute(path: '/success', builder: (_, __) => const Scaffold(body: Text('Account destination'))),
      ]);
      addTearDown(router.dispose);
      await tester.pumpWidget(ProviderScope(overrides: [authProvider.overrideWith(CeoAuthFixture.new)],
        child: localized(const SizedBox(), router: router, language: language)));
      await tester.pumpAndSettle();
      expect(find.text('ceo@example.test'), findsOneWidget);
      expect(find.textContaining('fully implemented'), findsNothing);
      expect(find.text('100% READY'), findsNothing);
      expect(tester.takeException(), isNull);
      final button = find.byWidgetPredicate((w) => w is Semantics && w.properties.label == 'ceo-workspace-account');
      await tester.tap(button);
      await tester.pumpAndSettle();
      expect(find.text('Account destination'), findsOneWidget);
    });
  }
  test('CEO dashboard excludes guests and ordinary client roles', () {
    const route = '/offices/corporate/roles/ceo/dashboard';
    expect(RouteGuard.verify(requestedRoute: route, isLoggedIn: false, userRole: null).isAllowed, isFalse);
    expect(RouteGuard.verify(requestedRoute: route, isLoggedIn: true, userRole: 'client').isAllowed, isFalse);
    expect(RouteGuard.verify(requestedRoute: route, isLoggedIn: true, userRole: 'ceo').isAllowed, isTrue);
  });
}
