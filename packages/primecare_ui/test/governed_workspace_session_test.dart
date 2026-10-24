import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/src/theme/prime_theme.dart';
import 'package:primecare_ui/src/features/workspace/governed_workspace_screen.dart';
import 'package:primecare_ui/src/features/generated_screens/ceo_dashboard.dart';
import 'package:primecare_ui/src/features/generated_screens/hr_director_dashboard.dart';
import 'package:primecare_ui/src/features/generated_screens/hr_hiring_dashboard.dart';

const route = '/offices/corporate/roles/ceo/dashboard';
AuthState session({String user = 'alice', String tenant = 'tenant-a', String token = 'fixture-a', String role = 'ceo'}) =>
    AuthState(isInitialized: true, isAuthenticated: true, userId: user, tenantId: tenant, token: token, role: role);
class WorkspaceAuthFixture extends AuthNotifier {
  @override
  AuthState build() => session();
  void replace(AuthState value) { state = value; }
}

void main() {
  final labels = (jsonDecode(File('lib/src/localization/screens/workspace.json').readAsStringSync())['locales']['en'] as Map)
      .map((key, value) => MapEntry('workspace.$key', value));
  Map<String, dynamic> response(String name, {bool permitted = true}) => {
    'identity': {'role': 'ceo'}, 'resources': labels,
    'screens': permitted ? [{'code': 'ceo_dashboard', 'name': name, 'route': route, 'renderer': 'dashboard', 'sections': <Object>[]}] : <Object>[],
    'actions': <Object>[], 'inventory': <Object>[],
    'overview': {'activeAccounts': 1, 'activeSessions': 1, 'accountRoles': <Object>[], 'activity': <Object>[], 'metrics': <Object>[]},
  };

  test('CEO and HR entries inherit one API-backed dashboard entry', () {
    for (final screen in [const CeoDashboardScreen(), const HrDirectorDashboardScreen(), const HrHiringDashboardScreen()]) {
      expect(screen, isA<GovernedWorkspaceEntry>());
    }
  });

  Future<ProviderContainer> mount(WidgetTester tester, void Function(RequestOptions, RequestInterceptorHandler) handle) async {
    final dio = Dio(BaseOptions(baseUrl: 'https://synthetic.invalid'));
    dio.interceptors.add(InterceptorsWrapper(onRequest: handle));
    final container = ProviderContainer(overrides: [
      authProvider.overrideWith(WorkspaceAuthFixture.new),
      apiClientProvider.overrideWith((ref) => ApiClient(ref, transport: dio)),
    ]);
    addTearDown(container.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: PrimeTheme(data: const PrimeThemeData(),
      child: const MaterialApp(home: GovernedWorkspaceScreen(route: route)))));
    await tester.pumpAndSettle();
    return container;
  }

  for (final change in ['user', 'tenant', 'role', 'token']) {
    testWidgets('cached dashboard and delayed response are discarded on $change change', (tester) async {
      var calls = 0;
      final delayed = <(RequestOptions, RequestInterceptorHandler)>[];
      final container = await mount(tester, (options, handler) {
        expect(options.path, '/v1/governance/workspace');
        calls++;
        if (calls == 1) { handler.resolve(Response(requestOptions: options, statusCode: 200, data: response('Private Alice'))); }
        else { delayed.add((options, handler)); }
      });
      expect(find.text('Private Alice'), findsWidgets);
      final auth = container.read(authProvider.notifier) as WorkspaceAuthFixture;
      auth.replace(session(user: change == 'user' ? 'bob' : 'alice', tenant: change == 'tenant' ? 'tenant-b' : 'tenant-a',
        role: change == 'role' ? 'hr_director' : 'ceo', token: change == 'token' ? 'fixture-b' : 'fixture-a'));
      await tester.pump();
      expect(find.text('Private Alice'), findsNothing);
      await tester.pump(const Duration(milliseconds: 10));
      expect(calls, 2);
      auth.replace(AuthState(isInitialized: true));
      await tester.pump();
      for (final (options, handler) in delayed) {
        handler.resolve(Response(requestOptions: options, statusCode: 200, data: response('Late private response')));
      }
      await tester.pumpAndSettle();
      expect(find.text('Late private response'), findsNothing);
      expect(find.text('Private Alice'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('a page absent from the current server grant stays forbidden', (tester) async {
    await mount(tester, (options, handler) => handler.resolve(Response(requestOptions: options, statusCode: 200, data: response('Forbidden private name', permitted: false))));
    expect(find.text('Forbidden private name'), findsNothing);
    expect(find.text(labels['workspace.forbidden'] as String), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
