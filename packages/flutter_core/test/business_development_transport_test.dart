import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/src/network/api_client.dart';
import 'package:flutter_core/src/network/local_cache_service.dart';

class BusinessCache extends LocalCacheService {
  BusinessCache() : super(null);
  int reads = 0, writes = 0;
  @override
  Map<String, dynamic>? getCachedResponse(String path) {
    reads++;
    return {
      'metrics': {'pipelineValue': 5000000},
    };
  }

  @override
  Future<void> cacheResponse(String path, Map<String, dynamic> data) async {
    writes++;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  for (final path in [
    '/v1/business-development',
    '/v1/business-development-analytics',
    '/v1/business-development-compliance?limit=2',
    'https://api.example.test/v1/business-development-workflow/',
  ]) {
    for (final method in ['GET', 'POST', 'PUT', 'PATCH', 'DELETE']) {
      for (final status in [null, 401, 403, 404, 501]) {
        test(
          '$method $path preserves failure $status without synthetic success',
          () async {
            final cache = BusinessCache();
            final container = ProviderContainer(
              overrides: [localCacheServiceProvider.overrideWithValue(cache)],
            );
            final dio = Dio(BaseOptions(baseUrl: 'https://api.example.test'));
            final client = container.read(
              Provider((ref) => ApiClient(ref, transport: dio)),
            );
            addTearDown(() {
              dio.close(force: true);
              container.dispose();
            });
            dio.interceptors.clear();
            dio.interceptors.add(
              InterceptorsWrapper(
                onRequest: (options, handler) {
                  expect(options.method, method);
                  handler.reject(
                    DioException(
                      requestOptions: options,
                      type: status == null
                          ? DioExceptionType.connectionTimeout
                          : DioExceptionType.badResponse,
                      response: status == null
                          ? null
                          : Response(
                              requestOptions: options,
                              statusCode: status,
                              data: {'error': 'Business unavailable'},
                            ),
                    ),
                  );
                },
              ),
            );
            final response = switch (method) {
              'GET' => await client.get(path),
              'POST' => await client.post(path, body: {'event': 'requested'}),
              'PUT' => await client.put(path, body: {'event': 'requested'}),
              'PATCH' => await client.patch(path, body: {'event': 'requested'}),
              _ => await client.delete(path),
            };
            expect(response.statusCode, status ?? 503);
            expect(response.isSuccess, isFalse);
            expect(response.error, isNotNull);
            expect(
              response.data,
              status == null ? isEmpty : {'error': 'Business unavailable'},
            );
            expect(cache.reads, 0);
            expect(cache.writes, 0);
          },
        );
      }
    }
  }
  test(
    'actual successful business response passes through without path-only caching',
    () async {
      final cache = BusinessCache();
      final container = ProviderContainer(
        overrides: [localCacheServiceProvider.overrideWithValue(cache)],
      );
      final dio = Dio(BaseOptions(baseUrl: 'https://api.example.test'));
      final client = container.read(
        Provider((ref) => ApiClient(ref, transport: dio)),
      );
      addTearDown(() {
        dio.close(force: true);
        container.dispose();
      });
      dio.interceptors.clear();
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            handler.resolve(
              Response(
                requestOptions: options,
                statusCode: 200,
                data: {
                  'metrics': {'leadsGenerated': 2},
                },
              ),
            );
          },
        ),
      );
      final response = await client.get('/v1/business-development');
      expect(response.data, {
        'metrics': {'leadsGenerated': 2},
      });
      expect(response.statusCode, 200);
      expect(cache.reads, 0);
      expect(cache.writes, 0);
    },
  );
}
