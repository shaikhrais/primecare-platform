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

class CeoWorkspaceApi extends Fake implements ApiClient {
  CeoWorkspaceApi(this.language);
  final String language;
  final calls = <String>[];
  @override
  Future<ApiResponse> get(String path, {Map<String,dynamic>? queryParameters}) async {
    if (path != '/v1/governance/workspace') throw StateError('Unexpected request: $path');
    calls.add(path);
    return ApiResponse(statusCode: 200, data: <String,dynamic>{
      'resources': <String,String>{'workspace.title': 'CEO fixture workspace'},
      'screens': <Map<String,dynamic>>[{'code': 'ceo_dashboard', 'name': 'CEO $language workspace',
        'route': '/offices/corporate/roles/ceo/dashboard', 'sections': <Map<String,dynamic>>[]}],
      'overview': <String,dynamic>{'activeAccounts': 0, 'activeSessions': 0,
        'accountRoles': <Map<String,dynamic>>[], 'activity': <Map<String,dynamic>>[]},
      'inventory': <Map<String,dynamic>>[], 'actions': <Map<String,dynamic>>[],
    });
  }
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
      final api = CeoWorkspaceApi(language);
      await tester.pumpWidget(ProviderScope(overrides: [authProvider.overrideWith(CeoAuthFixture.new),
        apiClientProvider.overrideWithValue(api)],
        child: localized(const SizedBox(), router: router, language: language)));
      await tester.pumpAndSettle();
      expect(find.text('CEO $language workspace'), findsWidgets);
      expect(api.calls, ['/v1/governance/workspace']);
      expect(find.textContaining('fully implemented'), findsNothing);
      expect(find.text('100% READY'), findsNothing);
      expect(tester.takeException(), isNull);
      final button = find.byIcon(Icons.account_circle_outlined);
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
