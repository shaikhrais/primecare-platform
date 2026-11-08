import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/src/network/api_client.dart';
import 'package:flutter_core/src/network/local_cache_service.dart';

// These paths are the existing generated GET requests, not new API bindings.
const _executivePaths = [
  '/v1/growth-pipeline',
  '/v1/regional-performance',
  '/v1/leadership-reports',
];
const _staleData = <String, dynamic>{'record': 'another-session-cached-data'};
const _errorData = <String, dynamic>{'error': 'executive read unavailable'};
const _realData = <String, dynamic>{'record': 'actual-transport-data'};

class _ProbeCache extends LocalCacheService {
  _ProbeCache(this.cachedData) : super(null);

  final Map<String, dynamic>? cachedData;
  int reads = 0;
  int writes = 0;

  @override
  Map<String, dynamic>? getCachedResponse(String path) {
    reads++;
    return cachedData;
  }

  @override
  Future<void> cacheResponse(String path, Map<String, dynamic> data) async {
    writes++;
  }
}

// Even a broken fixture must not open a socket.
class _NoNetworkAdapter implements HttpClientAdapter {
  int attempts = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    attempts++;
    throw StateError('Network access is forbidden in this test.');
  }

  @override
  void close({bool force = false}) {}
}

class _Harness {
  _Harness({Map<String, dynamic>? cachedData})
      : cache = _ProbeCache(cachedData) {
    container = ProviderContainer(
      overrides: [localCacheServiceProvider.overrideWithValue(cache)],
    );
    dio = Dio(BaseOptions(baseUrl: 'https://api.example.invalid'));
    dio.httpClientAdapter = adapter;
    client = container.read(
      Provider((ref) => ApiClient(ref, transport: dio)),
    );
    // This isolates ApiClient's failure boundary from session/device plugins.
    dio.interceptors.clear();
    addTearDown(() {
      expect(adapter.attempts, 0);
      dio.close(force: true);
      container.dispose();
    });
  }

  final _ProbeCache cache;
  final _NoNetworkAdapter adapter = _NoNetworkAdapter();
  late final ProviderContainer container;
  late final Dio dio;
  late final ApiClient client;
  int requests = 0;

  void fail(DioExceptionType type, {int? statusCode}) {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      requests++;
      handler.reject(DioException(
        requestOptions: options,
        type: type,
        response: statusCode == null
            ? null
            : Response(
                requestOptions: options,
                statusCode: statusCode,
                data: _errorData,
              ),
      ));
    }));
  }

  void respond(int? statusCode) {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      requests++;
      handler.resolve(Response(
        requestOptions: options,
        statusCode: statusCode,
        data: _realData,
      ));
    }));
  }

  void expectUncached() {
    expect(requests, 1);
    expect(cache.reads, 0);
    expect(cache.writes, 0);
    expect(adapter.attempts, 0);
  }
}

void _expectFailure(ApiResponse response, int statusCode, dynamic data) {
  expect(response.statusCode, statusCode);
  expect(response.isSuccess, isFalse);
  expect(response.error, isNotNull);
  expect(response.data, data);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  for (final path in _executivePaths) {
    for (final cachedData in [null, _staleData]) {
      final cacheState = cachedData == null ? 'empty cache' : 'stale cache';
      for (final status in [400, 401, 403, 404, 405, 408, 429, 500, 502, 503]) {
        test('$path preserves HTTP $status with $cacheState', () async {
          final h = _Harness(cachedData: cachedData);
          h.fail(DioExceptionType.badResponse, statusCode: status);
          final response = await h.client.get(path);
          _expectFailure(response, status, _errorData);
          h.expectUncached();
        });
      }

      for (final type in DioExceptionType.values) {
        test('$path fails closed for $type with $cacheState', () async {
          final h = _Harness(cachedData: cachedData);
          h.fail(type);
          final response = await h.client.get(path);
          _expectFailure(response, 503, isEmpty);
          h.expectUncached();
        });
      }

      for (final status in [200, 201, 204, 299]) {
        test('$path rejects Dio error carrying $status with $cacheState', () async {
          final h = _Harness(cachedData: cachedData);
          h.fail(DioExceptionType.unknown, statusCode: status);
          final response = await h.client.get(path);
          _expectFailure(response, 503, _errorData);
          h.expectUncached();
        });
      }
    }

    for (final variant in [
      '$path?enable-semantics=true',
      '$path/',
      'https://api.example.invalid$path?enable-semantics=true',
      'https://api.example.invalid$path/?enable-semantics=true',
      '/v1/../v1/${path.split('/').last}?enable-semantics=true',
    ]) {
      for (final status in [null, 401, 403, 404, 503]) {
        test('$variant preserves failure $status without stale cache', () async {
          final h = _Harness(cachedData: _staleData);
          h.fail(
            status == null
                ? DioExceptionType.connectionError
                : DioExceptionType.badResponse,
            statusCode: status,
          );
          final response = await h.client.get(variant);
          _expectFailure(response, status ?? 503, status == null ? isEmpty : _errorData);
          h.expectUncached();
        });
      }
    }

    for (final status in [200, 201, 299]) {
      test('$path returns actual $status data without cache access', () async {
        final h = _Harness(cachedData: _staleData);
        h.respond(status);
        final response = await h.client.get(
          path,
          queryParameters: {'enable-semantics': 'true'},
        );
        expect(response.statusCode, status);
        expect(response.isSuccess, isTrue);
        expect(response.error, isNull);
        expect(response.data, _realData);
        h.expectUncached();
      });
    }

    test('$path never defaults a missing response status to success', () async {
      final h = _Harness(cachedData: _staleData);
      h.respond(null);
      final response = await h.client.get(path);
      expect(response.statusCode, 503);
      expect(response.isSuccess, isFalse);
      h.expectUncached();
    });

    // Similar names and descendants are not silently added to the policy.
    for (final unrelated in ['$path-extra', '$path/child']) {
      test('$unrelated retains existing cache fallback', () async {
        final h = _Harness(cachedData: _staleData);
        h.fail(DioExceptionType.connectionError);
        final response = await h.client.get(unrelated);
        expect(response.statusCode, 200);
        expect(response.data, _staleData);
        expect(h.cache.reads, 1);
        expect(h.cache.writes, 0);
      });
    }

    // Guard scope, not endorsement: write fallback remains a separate issue.
    for (final method in ['POST', 'PUT', 'PATCH', 'DELETE']) {
      test('$method $path retains existing non-GET behavior', () async {
        final h = _Harness(cachedData: _staleData);
        h.fail(DioExceptionType.connectionError);
        final response = switch (method) {
          'POST' => await h.client.post(path, body: {}),
          'PUT' => await h.client.put(path, body: {}),
          'PATCH' => await h.client.patch(path, body: {}),
          _ => await h.client.delete(path),
        };
        expect(response.statusCode, 200);
        expect(response.data['status'], 'offline_fallback');
        h.expectUncached();
      });
    }
  }

  test('unrelated GET success retains existing cache writes', () async {
    final h = _Harness();
    h.respond(200);
    final response = await h.client.get('/v1/unrelated-fixture');
    expect(response.data, _realData);
    expect(response.isSuccess, isTrue);
    expect(h.cache.reads, 0);
    expect(h.cache.writes, 1);
  });

  test('unrelated GET failure retains existing offline fallback', () async {
    final h = _Harness();
    h.fail(DioExceptionType.connectionError);
    final response = await h.client.get('/v1/unrelated-fixture');
    expect(response.statusCode, 200);
    expect(response.data['status'], 'offline_fallback');
    expect(h.cache.reads, 1);
    expect(h.cache.writes, 0);
  });
}
