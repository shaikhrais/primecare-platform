import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/communications/communication_core.dart';
import 'package:flutter_core/communications/registered_communication_bindings.dart';
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
    }, maxPictureBytes: 1024);

  test('inherits dispatch, uses authenticated session, preserves key and version', () async {
    final hub = CommunicationHub(transport('message.send'));
    final result = await hub.messages.send('thread', 'deduplicate', 1, 'Fixture');
    expect(result['version'], 2);
    expect(requests.single.headers['Authorization'], 'Bearer synthetic-session');
    expect(requests.single.followRedirects, isFalse);
    expect(requests.single.data['key'], 'deduplicate');
    expect(requests.single.data['version'], 1);
  });
  test('production-generated inbox binding omits the internal action field', () async {
    final hub = CommunicationHub(DioCommunicationTransport(dio, registeredCommunicationBindings, maxPictureBytes: 1024));
    await hub.messages.inbox(limit: 10);
    expect(requests.single.path, '/v1/messages/inbox');
    expect(requests.single.method, 'GET');
    expect(requests.single.queryParameters, {'limit': 10});
    expect(registeredCommunicationBindings.length, 16);
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
  test('picture open reads a bounded private raster stream', () async {
    final png = [137, 80, 78, 71, 13, 10, 26, 10];
    dio.interceptors.clear();
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      requests.add(options);
      handler.resolve(Response(requestOptions: options, statusCode: 200,
        headers: Headers.fromMap({'content-type': ['image/png'], 'content-length': ['8']}),
        data: ResponseBody(Stream.value(Uint8List.fromList(png)), 200)));
    }));
    final result = await CommunicationHub(transport('picture.open', method: 'GET')).pictures.open('thread', 'picture');
    expect(result['bytes'], png);
    expect(result['mediaType'], 'image/png');
    expect(requests.single.responseType, ResponseType.stream);
  });
  test('picture open rejects oversized, mislabeled and truncated streams', () async {
    for (final variant in ['oversized', 'wrong-type', 'truncated']) {
      dio.interceptors.clear();
      dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        final bytes = variant == 'oversized' ? Uint8List(1025) : Uint8List.fromList([137, 80, 78, 71, 13, 10, 26, 10]);
        handler.resolve(Response(requestOptions: options, statusCode: 200,
          headers: Headers.fromMap({'content-type': [variant == 'wrong-type' ? 'image/svg+xml' : 'image/png'],
            if (variant == 'truncated') 'content-length': ['9']}),
          data: ResponseBody(Stream.value(bytes), 200)));
      }));
      await expectLater(CommunicationHub(transport('picture.open', method: 'GET')).pictures.open('thread', 'picture'), throwsStateError);
    }
  });
  test('network failure propagates without retry' , () async {
    dio.interceptors.clear();
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      requests.add(options);
      handler.reject(DioException(requestOptions: options, type: DioExceptionType.connectionError));
    }));
    await expectLater(CommunicationHub(transport('audio.accept')).audio.call('accept', 'thread', 'once', 1, 'call'), throwsA(isA<DioException>()));
    expect(requests.length, 1);
  });
}
