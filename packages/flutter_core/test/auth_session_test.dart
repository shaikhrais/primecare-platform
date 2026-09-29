import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_core/src/network/api_client.dart';
import 'package:flutter_core/src/security/security_interceptor.dart';

class FixtureAuth extends AuthNotifier {
  @override
  AuthState build() => AuthState(
    isInitialized: true, isAuthenticated: true, token: 'actor-token',
    role: 'ceo', userId: 'actor-id', tenantId: 'actor-tenant',
  );
}

class RecordingAuth extends FixtureAuth {
  int logoutCalls = 0;
  @override
  Future<void> logout() async { logoutCalls++; }
}

class FixtureApi extends Fake implements ApiClient {
  FixtureApi(this.status);
  final int status;
  final calls = <String>[];
  dynamic lastBody;
  @override
  Future<ApiResponse> revokeSession(String token) => post('/v1/auth/logout');
  @override
  Future<ApiResponse> post(String path, {dynamic body}) async {
    calls.add(path);
    lastBody = body;
    return ApiResponse(statusCode: status, data: <String, dynamic>{});
  }
}

class DeferredApi extends Fake implements ApiClient {
  final identity = Completer<ApiResponse>();
  final identityStarted = Completer<void>();
  final logins = <Completer<ApiResponse>>[];
  final revoked = <String>[];
  Completer<ApiResponse>? pendingLogout;

  @override
  Future<ApiResponse> get(String path, {Map<String, dynamic>? queryParameters}) {
    if (!identityStarted.isCompleted) identityStarted.complete();
    return identity.future;
  }

  @override
  Future<ApiResponse> post(String path, {dynamic body}) {
    final result = Completer<ApiResponse>();
    logins.add(result);
    return result.future;
  }

  @override
  Future<ApiResponse> revokeSession(String token) async {
    revoked.add(token);
    return pendingLogout == null
        ? ApiResponse(statusCode: 200, data: {})
        : await pendingLogout!.future;
  }
}

ApiResponse loginReply(String token) => ApiResponse(statusCode: 200, data: {
  'token': token, 'role': 'ceo', 'userId': '$token-user',
});

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    authListenable.value = false;
  });

  for (final status in [200, 201, 400, 403]) {
    test('provisioning response $status never replaces actor session', () async {
      final api = FixtureApi(status);
      final container = ProviderContainer(overrides: [
        apiClientProvider.overrideWithValue(api),
        authProvider.overrideWith(FixtureAuth.new),
      ]);
      addTearDown(container.dispose);
      final before = container.read(authProvider);
      final result = await container.read(authProvider.notifier).register(
        'new@example.test', 'test-password-only', 'First', 'Last', 'rmt',
      );
      expect(result, status == 200 || status == 201);
      expect(api.calls, ['/v1/auth/register']);
      expect(api.lastBody, {
        'email': 'new@example.test', 'password': 'test-password-only', 'role': 'rmt',
      });
      expect(identical(container.read(authProvider), before), isTrue);
      expect((await SharedPreferences.getInstance()).getString('auth_token'), isNull);
    });
  }

  test('logout clears persistence and leaves routing initialized on rejected revoke', () async {
    SharedPreferences.setMockInitialValues({
      'auth_token': 'actor-token', 'auth_role': 'ceo',
      'auth_tenant_id': 'actor-tenant', 'auth_user_id': 'actor-id',
      'auth_username': 'Actor', 'auth_preferred_language': 'en',
    });
    final api = FixtureApi(401);
    final container = ProviderContainer(overrides: [
      apiClientProvider.overrideWithValue(api),
      authProvider.overrideWith(FixtureAuth.new),
    ]);
    addTearDown(container.dispose);
    await container.read(authProvider.notifier).logout();
    final state = container.read(authProvider);
    expect(state.isInitialized, isTrue);
    expect(state.isAuthenticated, isFalse);
    expect(state.token, isNull);
    expect(authListenable.value, isFalse);
    expect(api.calls, ['/v1/auth/logout']);
    expect((await SharedPreferences.getInstance()).getKeys(), {'auth_preferred_language'});
  });

  test('late stored session cannot restore authentication after logout', () async {
    SharedPreferences.setMockInitialValues({'auth_token': 'old-token', 'auth_role': 'ceo'});
    final api = DeferredApi();
    final container = ProviderContainer(overrides: [apiClientProvider.overrideWithValue(api)]);
    addTearDown(container.dispose);
    final auth = container.read(authProvider.notifier);
    await api.identityStarted.future;
    await auth.logout();
    api.identity.complete(ApiResponse(statusCode: 200, data: {'userId': 'old-user', 'roles': 'ceo'}));
    await Future<void>.delayed(Duration.zero);
    expect(container.read(authProvider).isAuthenticated, isFalse);
    expect(container.read(authProvider).token, isNull);
    expect(authListenable.value, isFalse);
    expect((await SharedPreferences.getInstance()).getString('auth_token'), isNull);
  });

  test('late login is discarded and its issued token revoked after logout', () async {
    final api = DeferredApi();
    final container = ProviderContainer(overrides: [
      apiClientProvider.overrideWithValue(api), authProvider.overrideWith(FixtureAuth.new),
    ]);
    addTearDown(container.dispose);
    final auth = container.read(authProvider.notifier);
    final login = auth.login('fixture@example.test', 'fixture-password');
    await auth.logout();
    api.logins.single.complete(loginReply('late-token'));
    expect(await login, isFalse);
    expect(api.revoked, ['actor-token', 'late-token']);
    expect(container.read(authProvider).isAuthenticated, isFalse);
    expect((await SharedPreferences.getInstance()).getString('auth_token'), isNull);
  });

  test('delayed logout revokes old token and does not clear a newer login', () async {
    final api = DeferredApi()..pendingLogout = Completer<ApiResponse>();
    final container = ProviderContainer(overrides: [
      apiClientProvider.overrideWithValue(api), authProvider.overrideWith(FixtureAuth.new),
    ]);
    addTearDown(container.dispose);
    final auth = container.read(authProvider.notifier);
    final logout = auth.logout();
    expect(container.read(authProvider).isAuthenticated, isFalse);
    final login = auth.login('fixture@example.test', 'fixture-password');
    api.logins.single.complete(loginReply('new-token'));
    expect(await login, isTrue);
    api.pendingLogout!.complete(ApiResponse(statusCode: 200, data: {}));
    await logout;
    expect(api.revoked, ['actor-token']);
    expect(container.read(authProvider).token, 'new-token');
    expect((await SharedPreferences.getInstance()).getString('auth_token'), 'new-token');
  });

  test('latest login wins when responses finish out of order', () async {
    final api = DeferredApi();
    final container = ProviderContainer(overrides: [
      apiClientProvider.overrideWithValue(api), authProvider.overrideWith(FixtureAuth.new),
    ]);
    addTearDown(container.dispose);
    final auth = container.read(authProvider.notifier);
    final first = auth.login('first@example.test', 'fixture-password');
    final second = auth.login('second@example.test', 'fixture-password');
    api.logins[1].complete(loginReply('second-token'));
    expect(await second, isTrue);
    api.logins[0].complete(loginReply('first-token'));
    expect(await first, isFalse);
    expect(api.revoked, ['first-token']);
    expect(container.read(authProvider).token, 'second-token');
    expect((await SharedPreferences.getInstance()).getString('auth_token'), 'second-token');
  });

  test('rejected startup identity clears every cached identity field', () async {
    SharedPreferences.setMockInitialValues({
      'auth_token': 'old-token', 'auth_role': 'ceo', 'auth_user_id': 'old-user',
      'auth_tenant_id': 'untrusted-tenant', 'auth_username': 'Old', 'auth_preferred_language': 'fr',
    });
    final api = DeferredApi();
    final container = ProviderContainer(overrides: [apiClientProvider.overrideWithValue(api)]);
    addTearDown(container.dispose);
    container.read(authProvider);
    await api.identityStarted.future;
    api.identity.complete(ApiResponse(statusCode: 401, data: {}));
    await Future<void>.delayed(const Duration(milliseconds: 20));
    expect(container.read(authProvider).isInitialized, isTrue);
    expect(container.read(authProvider).isAuthenticated, isFalse);
    expect((await SharedPreferences.getInstance()).getKeys(), {'auth_preferred_language'});
  });

  final cases = [
    ('/v1/auth/logout', 'actor-token', 401, 0),
    ('https://api.example.test/v1/auth/logout?x=1', 'actor-token', 401, 0),
    ('/v1/auth/login', 'actor-token', 401, 0),
    ('/v1/auth/change-password', 'actor-token', 401, 0),
    ('/v1/user/change-password', 'actor-token', 401, 0),
    ('/api/auth/login', 'actor-token', 401, 0),
    ('/api/auth/logout', 'actor-token', 401, 0),
    ('/api/auth/me', 'actor-token', 401, 1),
    ('/v1/auth/me', 'old-token', 401, 0),
    ('/v1/auth/me', '', 401, 0),
    ('/v1/auth/me', 'actor-token', 401, 1),
    ('/v1/auth/me', 'actor-token', 403, 0),
    ('/v1/auth/me', 'actor-token', 429, 0),
  ];
  for (final example in cases) {
    test('401 handling ${example.$1} token=${example.$2} status=${example.$3}', () async {
      final notifier = RecordingAuth();
      final container = ProviderContainer(overrides: [
        authProvider.overrideWith(() => notifier),
      ]);
      addTearDown(container.dispose);
      final dio = Dio(BaseOptions(baseUrl: 'https://api.example.test'));
      addTearDown(() => dio.close(force: true));
      // Reject at the transport boundary, before device fingerprint middleware.
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) => handler.reject(DioException(
          requestOptions: options, type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: options, statusCode: example.$3,
            data: <String, dynamic>{'error': 'Rejected'},
          ),
        ), true),
      ));
      final interceptor = container.read(Provider((ref) => SecurityInterceptor(ref)));
      dio.interceptors.add(interceptor);
      await expectLater(
        dio.get<dynamic>(example.$1, options: Options(headers: {
          if (example.$2.isNotEmpty) 'Authorization': 'Bearer ${example.$2}',
        })),
        throwsA(isA<DioException>()),
      );
      expect(notifier.logoutCalls, example.$4);
    });
  }
}
