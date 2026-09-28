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
  Future<ApiResponse> post(String path, {dynamic body}) async {
    calls.add(path);
    lastBody = body;
    return ApiResponse(statusCode: status, data: <String, dynamic>{});
  }
}

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
    expect((await SharedPreferences.getInstance()).getKeys(), isEmpty);
  });

  final cases = [
    ('/v1/auth/logout', 'actor-token', 401, 0),
    ('https://api.example.test/v1/auth/logout?x=1', 'actor-token', 401, 0),
    ('/v1/auth/login', 'actor-token', 401, 0),
    ('/v1/auth/change-password', 'actor-token', 401, 0),
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
