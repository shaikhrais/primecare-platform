import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/communications/communication_core.dart';
import 'package:flutter_core/communications/dio_communication_transport.dart';

void main() {
  late Dio dio;
  late List<RequestOptions> requests;
  setUp(() {
    requests = [];
    dio = Dio(BaseOptions(baseUrl: 'https://api.example.invalid',
      headers: {'Authorization': 'Bearer synthetic-session'}));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      requests.add(options);
      handler.resolve(Response(requestOptions: options, statusCode: 200,
        data: {'id': 'fixture', 'version': 2}));
    }));
  });
  tearDown(() => dio.close(force: true));
  DioCommunicationTransport transport(String key, {String method = 'POST'}) =>
    DioCommunicationTransport(dio, {
      key: CommunicationRouteBinding(path: '/v1/messages', method: method),
    });

  test('inherits dispatch, uses authenticated session, preserves key and version', () async {
    final hub = CommunicationHub(transport('message.send'));
    final result = await hub.messages.send('thread', 'deduplicate', 1, 'Fixture');
    expect(result['version'], 2);
    expect(requests.single.headers['Authorization'], 'Bearer synthetic-session');
    expect(requests.single.followRedirects, isFalse);
    expect(requests.single.data['key'], 'deduplicate');
    expect(requests.single.data['version'], 1);
  });
  test('read sends fields as query and no body', () async {
    await CommunicationHub(transport('message.read', method: 'GET')).messages.read('thread');
    expect(requests.single.method, 'GET');
    expect(requests.single.data, isNull);
    expect(requests.single.queryParameters, {'action': 'read', 'id': 'thread'});
  });
  test('picture is multipart with actual copied bytes and fixed filename', () async {
    final source = Uint8List.fromList([137, 80, 78, 71]);
    await CommunicationHub(transport('picture.upload')).pictures.upload('thread', source, 'image/png');
    source[0] = 0;
    final form = requests.single.data as FormData;
    expect(Map.fromEntries(form.fields)['threadId'], 'thread');
    expect(form.fields.any((entry) => entry.key == 'bytes'), isFalse);
    final file = form.files.single.value;
    expect(file.filename, 'picture.png');
    expect(file.contentType.toString(), 'image/png');
    expect(await file.finalize().expand((chunk) => chunk).toList(), [137, 80, 78, 71]);
  });
  test('unbound action, forged identity, inbound email and GET mutation never dispatch', () async {
    final adapter = transport('message.send', method: 'GET');
    for (final entry in <(String, Map<String, Object?>)>[
      ('message', {'action': 'read', 'id': 'thread'}),
      ('message', {'action': 'send', 'tenantId': 'other'}),
      ('email', {'action': 'receive'}),
      ('message', {'action': 'send', 'id': 'thread'}),
    ]) {
      await expectLater(adapter.execute(entry.$1, entry.$2), throwsA(anything));
    }
    expect(requests, isEmpty);
  });
  test('invalid binary input never dispatches', () async {
    final hub = CommunicationHub(transport('picture.upload'));
    await expectLater(hub.pictures.upload('thread', Uint8List(0), 'image/png'), throwsArgumentError);
    await expectLater(hub.pictures.upload('thread', Uint8List.fromList([1]), 'image/svg+xml'), throwsArgumentError);
    expect(requests, isEmpty);
  });
  test('reject unsafe route mappings before any authenticated request', () {
    for (final path in ['https://other.invalid/v1/messages', '//other.invalid/v1/messages',
      '/v1/messages?token=x', '/v1/messages#fragment', '/v1/../auth',
      '/v1/%2e%2e/auth', '/v1//messages', '/outside']) {
      expect(() => CommunicationRouteBinding(path: path, method: 'POST'), throwsArgumentError);
    }
    expect(requests, isEmpty);
  });
  test('failed or malformed response never becomes success, even with interceptor resolution', () async {
    for (final status in [302, 401, 403, 409, 503, 200]) {
      dio.interceptors.clear();
      dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        requests.add(options);
        handler.resolve(Response(requestOptions: options, statusCode: status,
          data: status == 200 ? ['malformed'] : {'error': 'fixture'}));
      }));
      await expectLater(CommunicationHub(transport('email.deliver')).email.deliver('mail', 'once', 1), throwsStateError);
    }
    expect(requests.length, 6); // One attempt each, including ambiguous send failure.
  });
  test('network failure propagates without retry', () async {
    dio.interceptors.clear();
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      requests.add(options);
      handler.reject(DioException(requestOptions: options, type: DioExceptionType.connectionError));
    }));
    await expectLater(CommunicationHub(transport('audio.accept')).audio.call('accept', 'thread', 'once', 1, 'call'), throwsA(isA<DioException>()));
    expect(requests.length, 1);
  });
}
