import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_core/src/network/api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_governance/core/governance/route_registry.dart';

class GuardAuth extends AuthNotifier {
  @override
  AuthState build() => AuthState(isInitialized: true, isAuthenticated: true,
    userId: 'fixture-user', tenantId: 'fixture-tenant', token: 'fixture-token',
    role: 'fixture-role');
  void replace() => state = AuthState(isInitialized: true, isAuthenticated: true,
    userId: 'replacement-user', tenantId: 'fixture-tenant', token: 'replacement-token',
    role: 'fixture-role');
}

class GuardApi implements ApiClient {
  dynamic data;
  int status = 200;
  Completer<ApiResponse>? pending;
  final paths = <String>[];
  @override
  Future<ApiResponse> get(String path, {Map<String, dynamic>? queryParameters}) async {
    paths.add(path);
    return pending == null ? ApiResponse(statusCode: status, data: data) : await pending!.future;
  }
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  const path = '/admin/screen-health';
  Map<String, dynamic> projection() => {
    'identity': {'userId': 'fixture-user', 'role': 'fixture-role'},
    'landing': path, 'screens': [{'route': path}],
  };
  testWidgets('actual router requires server grants and rejects every ungranted native route', (tester) async {
    final api = GuardApi()..data = projection();
    final container = ProviderContainer(overrides: [
      authProvider.overrideWith(GuardAuth.new), apiClientProvider.overrideWithValue(api),
    ]);
    final router = container.read(appRouterProvider);
    addTearDown(router.dispose);
    addTearDown(container.dispose);
    late BuildContext context;
    await tester.pumpWidget(MaterialApp(home: Builder(builder: (value) {
      context = value; return const SizedBox.shrink();
    })));
    Future<String?> redirect(String target) async => router.configuration.topRedirect(context,
      GoRouterState(router.configuration, uri: Uri.parse(target), matchedLocation: target,
        fullPath: target, pathParameters: const {}, pageKey: ValueKey(target)));
    expect(await redirect(path), isNull);
    expect(await redirect('/login'), path);
    for (final code in [401, 403, 500]) {
      api.status = code;
      expect(await redirect(path), CommonRoutes.authError);
    }
    api.status = 200;
    api.data = {...projection(), 'screens': [], 'inventory': [{'route': path}]};
    for (final target in governanceNativeScreenRoutes) {
      expect(await redirect(target), CommonRoutes.authError, reason: target);
    }
    api.data = projection();
    final pending = api.pending = Completer<ApiResponse>();
    final oldRequest = redirect(path);
    (container.read(authProvider.notifier) as GuardAuth).replace();
    pending.complete(ApiResponse(statusCode: 200, data: projection()));
    expect(await oldRequest, CommonRoutes.authError);
    expect(api.paths.every((value) => value == '/v1/governance/workspace'), isTrue);
    expect(tester.takeException(), isNull);
  });
}
