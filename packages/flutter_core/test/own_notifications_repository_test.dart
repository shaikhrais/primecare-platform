import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/src/network/api_client.dart';
import 'package:flutter_core/src/repositories/own_notifications_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Dio dio;
  late ProviderContainer container;
  late OwnNotificationsRepository repository;
  final row = {
    'id': 'notification',
    'title': 'Schedule updated',
    'message': 'Recorded message',
    'type': 'schedule',
    'is_read': false,
    'created_at': '2026-10-08T00:00:00Z',
  };
  Map<String, dynamic> envelope(List<dynamic> rows) => {
    'notifications': rows,
    'pagination': {
      'limit': 25,
      'offset': 0,
      'total': rows.length,
      'hasMore': false,
    },
  };
  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://fixture.invalid'));
    container = ProviderContainer();
    final client = container.read(
      Provider((ref) => ApiClient(ref, transport: dio)),
    );
    dio.interceptors.clear();
    repository = OwnNotificationsRepository(client);
  });
  tearDown(() {
    container.dispose();
    dio.close(force: true);
  });
  test(
    'canonical owner GET has no owner overrides and adapts real list envelope',
    () async {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (o, h) {
            expect(o.path, '/v1/auth/me/notifications');
            expect(o.method, 'GET');
            expect(o.queryParameters, isEmpty);
            expect(o.data, isNull);
            h.resolve(
              Response(
                requestOptions: o,
                statusCode: 200,
                data: envelope([row]),
              ),
            );
          },
        ),
      );
      final r = await repository.load();
      expect(r.isSuccess, true);
      expect(r.data, [row]);
    },
  );
  test('empty owned response remains empty', () async {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (o, h) => h.resolve(
          Response(requestOptions: o, statusCode: 200, data: envelope([])),
        ),
      ),
    );
    expect((await repository.load()).data, isEmpty);
  });
  for (final status in [401, 403, 404, 503]) {
    test('preserves $status without old route fallback', () async {
      var calls = 0;
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (o, h) {
            calls++;
            expect(o.path, '/v1/auth/me/notifications');
            h.reject(
              DioException(
                requestOptions: o,
                type: DioExceptionType.badResponse,
                response: Response(
                  requestOptions: o,
                  statusCode: status,
                  data: {'error': 'denied'},
                ),
              ),
            );
          },
        ),
      );
      final r = await repository.load();
      expect(r.statusCode, status);
      expect(r.isSuccess, false);
      expect(calls, 1);
    });
  }
  test('malformed legacy camelCase notification DTO fails closed', () async {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (o, h) => h.resolve(
          Response(
            requestOptions: o,
            statusCode: 200,
            data: envelope([
              {'id': 'fake', 'isRead': false, 'timeAgo': '2m'},
            ]),
          ),
        ),
      ),
    );
    expect((await repository.load()).statusCode, 503);
  });
  for (final stamp in [
    '2026-02-30T00:00:00Z',
    '2026-10-08',
    '2026-10-08T24:00:00Z',
  ]) {
    test('invalid timestamp $stamp fails closed', () async {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (o, h) => h.resolve(
            Response(
              requestOptions: o,
              statusCode: 200,
              data: envelope([
                {...row, 'created_at': stamp},
              ]),
            ),
          ),
        ),
      );
      expect((await repository.load()).statusCode, 503);
    });
  }
  for (final stamp in [
    '2026-10-08T00:00:00.123Z',
    '2026-10-08T00:00:00.123456-04:00',
  ]) {
    test('valid RFC3339 timestamp $stamp remains recorded', () async {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (o, h) => h.resolve(
            Response(
              requestOptions: o,
              statusCode: 200,
              data: envelope([
                {...row, 'created_at': stamp},
              ]),
            ),
          ),
        ),
      );
      expect((await repository.load()).isSuccess, true);
    });
  }
}
