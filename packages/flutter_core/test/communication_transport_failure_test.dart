import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/src/network/api_client.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final methods = <String, Future<ApiResponse> Function(ApiClient, String)>{
    'GET': (client, path) => client.get(path),
    'POST': (client, path) => client.post(path, body: {'text': 'Fixture'}),
    'PUT': (client, path) => client.put(path, body: {}),
    'PATCH': (client, path) => client.patch(path, body: {}),
    'DELETE': (client, path) => client.delete(path),
  };
  for (final path in [
    '/v1/psw/messages', '/v1/messages/inbox',
    '/staff/communication', '/common/patient-messages', '/clinic/messaging',
    '/offices/clinical/roles/psw/messages', '/v1/communication',
    '/v1/messaging', '/v1/psw-messages', '/v1/patient-messages',
  ]) {
    for (final method in methods.entries) {
      test('${method.key} $path never replaces a failed request with demo success', () async {
        final dio = Dio(BaseOptions(baseUrl: 'https://api.example.invalid'));
        final container = ProviderContainer();
        addTearDown(container.dispose);
        addTearDown(() => dio.close(force: true));
        final client = container.read(Provider((ref) => ApiClient(ref, transport: dio)));
        dio.interceptors.clear();
        dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
          handler.reject(DioException(requestOptions: options, type: DioExceptionType.connectionError));
        }));
        final response = await method.value(client, '$path?enable-semantics=true');
        expect(response.isSuccess, isFalse);
        expect(response.statusCode, 503);
        expect(response.data, <String, dynamic>{});
      });
    }
    test('$path preserves forbidden responses and real successful responses', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://api.example.invalid'));
      final container = ProviderContainer();
      addTearDown(container.dispose);
      addTearDown(() => dio.close(force: true));
      final client = container.read(Provider((ref) => ApiClient(ref, transport: dio)));
      dio.interceptors.clear();
      dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        handler.reject(DioException(requestOptions: options, type: DioExceptionType.badResponse,
          response: Response(requestOptions: options, statusCode: 403, data: {'error': 'forbidden'})));
      }));
      expect((await client.post(path, body: {'text': 'Fixture'})).statusCode, 403);
      dio.interceptors.clear();
      dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        handler.resolve(Response(requestOptions: options, statusCode: 200, data: {'id': 'actual-response'}));
      }));
      final response = await client.post(path, body: {'text': 'Fixture'});
      expect(response.isSuccess, isTrue);
      expect(response.data, {'id': 'actual-response'});
    });
  }
}
