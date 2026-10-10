import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';

class Transport extends BaseApiTransport {
  final Future<ApiResponse> response;
  final calls = <(String, String, Object?)>[];
  Transport(this.response);
  @override
  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    calls.add(('get', path, queryParameters));
    return response;
  }

  @override
  Future<ApiResponse> post(String path, {dynamic body}) {
    calls.add(('post', path, body));
    return response;
  }

  @override
  Future<ApiResponse> put(String path, {dynamic body}) {
    calls.add(('put', path, body));
    return response;
  }

  @override
  Future<ApiResponse> patch(String path, {dynamic body}) {
    calls.add(('patch', path, body));
    return response;
  }

  @override
  Future<ApiResponse> delete(String path) {
    calls.add(('delete', path, null));
    return response;
  }
}

class Repository extends BaseTransportRepository<Transport> {
  Repository(super.client);
}

class Service extends BaseTelemetryService<Object> {
  Service(super.telemetry);
}

void main() {
  test(
    'typed repository forwards all verbs and preserves future identity',
    () async {
      final payload = <String, dynamic>{'id': 1};
      final result = ApiResponse(data: payload, statusCode: 200);
      final transport = Transport(Future.value(result));
      final repository = Repository(transport);
      final query = <String, dynamic>{'offset': 0};
      expect(repository.client, same(transport));
      final futures = [
        repository.get('/get', queryParameters: query),
        repository.post('/post', body: payload),
        repository.put('/put', body: payload),
        repository.patch('/patch', body: payload),
        repository.delete('/delete'),
      ];
      for (final future in futures) {
        expect(future, same(transport.response));
        expect(await future, same(result));
      }
      expect(transport.calls.map((call) => call.$1), [
        'get',
        'post',
        'put',
        'patch',
        'delete',
      ]);
      expect(transport.calls.map((call) => call.$2), [
        '/get',
        '/post',
        '/put',
        '/patch',
        '/delete',
      ]);
      expect(transport.calls.first.$3, same(query));
      for (final call in transport.calls.skip(1).take(3)) {
        expect(call.$3, same(payload));
      }
      expect(transport.calls.last.$3, isNull);
    },
  );
  test(
    'repository preserves transport errors without rewriting them',
    () async {
      final failure = StateError('transport unavailable');
      final transport = Transport(Future<ApiResponse>.error(failure));
      await expectLater(
        Repository(transport).get('/failed'),
        throwsA(same(failure)),
      );
    },
  );
  test(
    'telemetry parent preserves injection and inherited result service',
    () async {
      final telemetry = Object();
      final service = Service(telemetry);
      final BaseResultService root = service;
      expect(service.telemetry, same(telemetry));
      expect((await root.guard(() => 42)).getOrThrow(), 42);
    },
  );
}
