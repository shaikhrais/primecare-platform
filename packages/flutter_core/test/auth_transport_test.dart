import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/src/network/api_client.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('session revocation sends the captured bearer token', () async {
    final transport = Dio(BaseOptions(baseUrl: 'https://api.example.test'));
    final container = ProviderContainer();
    addTearDown(container.dispose);
    addTearDown(() => transport.close(force: true));
    final client = container.read(Provider((ref) => ApiClient(ref, transport: transport)));
    transport.interceptors.clear();
    transport.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      expect(options.path, '/v1/auth/logout');
      expect(options.headers['Authorization'], 'Bearer captured-old-token');
      handler.resolve(Response(requestOptions: options, statusCode: 200,
          data: <String, dynamic>{'status': 'signed_out'}));
    }));
    expect((await client.revokeSession('captured-old-token')).isSuccess, isTrue);
  });

  test('recovery acknowledgements reject malformed and cross-operation success', () {
    const forgot = {'message': 'If an active account matches, recovery instructions will be emailed. Check your inbox and spam folder.'};
    const reset = {'status': 'password_reset', 'reauthenticationRequired': true};
    for (final payload in <dynamic>[null, [], '', {}, {'message': 7},
      {'status': 'password_reset'},
      {'status': 'password_reset', 'reauthenticationRequired': 'true'},
      {'status': 'password_reset', 'reauthenticationRequired': false}]) {
      final response = ApiResponse(statusCode: 200, data: payload);
      expect(response.confirmsPasswordRecovery(), isFalse);
      expect(response.confirmsPasswordRecovery(reset: true), isFalse);
    }
    expect(ApiResponse(statusCode: 200, data: forgot).confirmsPasswordRecovery(), isTrue);
    expect(ApiResponse(statusCode: 200, data: forgot).confirmsPasswordRecovery(reset: true), isFalse);
    expect(ApiResponse(statusCode: 200, data: reset).confirmsPasswordRecovery(), isFalse);
    expect(ApiResponse(statusCode: 200, data: reset).confirmsPasswordRecovery(reset: true), isTrue);
    for (final status in [201, 400, 429, 503]) {
      expect(ApiResponse(statusCode: status, data: forgot).confirmsPasswordRecovery(), isFalse);
      expect(ApiResponse(statusCode: status, data: reset).confirmsPasswordRecovery(reset: true), isFalse);
    }
  });

  final calls = <String, Future<ApiResponse> Function(ApiClient, String)>{
    'GET': (client, path) => client.get(path),
    'POST': (client, path) => client.post(path, body: {'email': 'qa@example.test'}),
    'PUT': (client, path) => client.put(path, body: {}),
    'PATCH': (client, path) => client.patch(path, body: {}),
    'DELETE': (client, path) => client.delete(path),
  };

  for (final call in calls.entries) {
    for (final path in [
      '/v1/auth/forgot-password',
      '/v1/auth/me?probe=1',
      '/v1/user/change-password',
      'https://api.example.test/v1/admin/users?probe=1',
      '/api/auth/login',
      'https://api.example.test/v1/auth/admin/users',
    ]) {
      for (final status in <int?>[400, 401, 403, 409, 429, 500, 503, null]) {
        test('${call.key} $path preserves failure $status', () async {
          final transport = Dio(BaseOptions(baseUrl: 'https://api.example.test'));
          final container = ProviderContainer();
          addTearDown(container.dispose);
          addTearDown(() => transport.close(force: true));
          final client = container.read(Provider(
            (ref) => ApiClient(ref, transport: transport),
          ));
          // Replace device/session middleware only in this transport unit test.
          transport.interceptors.clear();
          transport.interceptors.add(InterceptorsWrapper(
            onRequest: (options, handler) => handler.reject(DioException(
              requestOptions: options,
              type: status == null
                  ? DioExceptionType.connectionTimeout
                  : DioExceptionType.badResponse,
              response: status == null ? null : Response(
                requestOptions: options,
                statusCode: status,
                data: {'error': 'Request rejected'},
              ),
            )),
          ));

          final response = await call.value(client, path);
          expect(response.isSuccess, isFalse);
          expect(response.statusCode, status ?? 503);
          expect(response.error, 'Authentication request failed.');
          expect(response.data, status == null ? isEmpty : {'error': 'Request rejected'});
        });
      }
    }
    test('${call.key} retains real auth success', () async {
      final transport = Dio(BaseOptions(baseUrl: 'https://api.example.test'));
      final container = ProviderContainer();
      addTearDown(container.dispose);
      addTearDown(() => transport.close(force: true));
      final client = container.read(Provider(
        (ref) => ApiClient(ref, transport: transport),
      ));
      transport.interceptors.clear();
      transport.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) => handler.resolve(Response(
          requestOptions: options,
          statusCode: 200,
          data: <String, dynamic>{'userId': 'qa-user'},
        )),
      ));
      final response = await call.value(client, '/v1/auth/me');
      expect(response.isSuccess, isTrue);
      expect(response.data, {'userId': 'qa-user'});
    });
  }
}
