import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/provider_service.dart';
import 'package:flutter_core/src/network/api_client.dart';
import 'package:flutter_core/src/network/local_cache_service.dart';
import 'package:flutter_core/src/resilience/execution_gate_service.dart';
import 'package:flutter_core/src/resilience/result.dart';

Map<String, dynamic> profile() => {
  'id': 'owned-provider',
  'full_name': 'Owned Provider',
  'bio': null,
  'languages': 'English',
  'service_areas': 'Hamilton',
  'provider_type': 'RMT',
  'is_approved': true,
  'skills': 'Massage',
};

class CountingTelemetry extends ExecutionGateService {
  int passed = 0;
  int failed = 0;
  @override
  void passGate(
    ExecutionGateCategory category,
    String message, {
    bool silent = false,
    Map<String, dynamic>? metadata,
  }) {
    passed++;
  }

  @override
  void failGate(
    ExecutionGateCategory category,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    failed++;
  }
}

class CountingCache extends LocalCacheService {
  CountingCache() : super(null);
  int reads = 0;
  int writes = 0;
  @override
  Map<String, dynamic>? getCachedResponse(String path) {
    reads++;
    return {
      'profile': {...profile(), 'id': 'different-session-provider'},
    };
  }

  @override
  Future<void> cacheResponse(String path, Map<String, dynamic> data) async {
    writes++;
  }
}

class Harness {
  final CountingTelemetry telemetry = CountingTelemetry();
  final CountingCache cache = CountingCache();
  late final ProviderContainer container;
  final Dio transport = Dio(BaseOptions(baseUrl: 'https://api.example.test'));
  late final ApiClient client;
  late final ProviderService service;
  Harness() {
    container = ProviderContainer(
      overrides: [localCacheServiceProvider.overrideWithValue(cache)],
    );
    client = container.read(
      Provider((ref) => ApiClient(ref, transport: transport)),
    );
    transport.interceptors.clear();
    service = ProviderService(client, telemetry);
  }
  void close() {
    transport.close(force: true);
    container.dispose();
  }

  void success(Object? data, {int status = 200}) {
    transport.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          expect(options.method, 'GET');
          expect(options.path, '/v1/provider/profile');
          expect(options.data, isNull);
          expect(options.queryParameters, isEmpty);
          handler.resolve(
            Response(requestOptions: options, statusCode: status, data: data),
          );
        },
      ),
    );
  }

  void failure(int? status) {
    transport.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
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
                      data: {'error': 'Rejected profile'},
                    ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'actual service reads canonical owned envelope without fabricated fields or caching',
    () async {
      final h = Harness();
      addTearDown(h.close);
      h.success({'profile': profile()});
      final result = await h.service.getSelfProfile();
      expect(result, isA<Success<ProviderProfile>>());
      final value = result.getOrThrow();
      expect(value.id, 'owned-provider');
      expect(value.fullName, 'Owned Provider');
      expect(value.role, ProviderRole.rmt);
      expect(value.bio, '');
      expect(value.serviceAreas, 'Hamilton');
      expect(value.isApproved, isTrue);
      expect(value.trustScore, isNull);
      expect(value.avatarUrl, isNull);
      expect(h.telemetry.passed, 1);
      expect(h.telemetry.failed, 0);
      expect(h.cache.reads, 0);
      expect(h.cache.writes, 0);
      expect(
        ApiConfig.endpoints['providerDashboard'],
        ApiConfig.endpoints['providerProfile'],
      );
    },
  );

  final malformed = <Object?>[
    null,
    {},
    profile(),
    {'profile': null},
    {'profile': <Object?>[]},
    {'profile': profile(), 'extra': true},
    {
      'profile': {...profile(), 'trust_score': 100},
    },
    {
      'profile': {...profile(), 'avatar_url': 'invented'},
    },
    for (final field in [
      'id',
      'full_name',
      'languages',
      'service_areas',
      'provider_type',
      'is_approved',
      'skills',
      'bio',
    ])
      {'profile': Map<String, dynamic>.from(profile())..remove(field)},
    for (final field in [
      'id',
      'full_name',
      'languages',
      'service_areas',
      'provider_type',
      'skills',
    ])
      {
        'profile': {...profile(), field: null},
      },
    {
      'profile': {...profile(), 'is_approved': 'true'},
    },
    {
      'profile': {...profile(), 'bio': 123},
    },
    {
      'profile': {...profile(), 'id': ''},
    },
  ];
  for (var index = 0; index < malformed.length; index++) {
    test(
      'malformed server response $index fails before successful telemetry',
      () async {
        final h = Harness();
        addTearDown(h.close);
        h.success(malformed[index]);
        expect(
          await h.service.getSelfProfile(),
          isA<Failure<ProviderProfile>>(),
        );
        expect(h.telemetry.passed, 0);
        expect(h.telemetry.failed, 1);
        expect(h.cache.reads, 0);
        expect(h.cache.writes, 0);
      },
    );
  }
  test('contract permits nullable biography and real string biography', () {
    expect(ProviderProfile.fromResponse({'profile': profile()}).bio, '');
    expect(
      ProviderProfile.fromResponse({
        'profile': {...profile(), 'bio': 'Actual biography'},
      }).bio,
      'Actual biography',
    );
  });
  for (final status in <int?>[401, 403, 404, 405, 429, 500, 503, null]) {
    test(
      'actual service preserves failure $status instead of returning an offline profile',
      () async {
        final h = Harness();
        addTearDown(h.close);
        h.failure(status);
        expect(
          await h.service.getSelfProfile(),
          isA<Failure<ProviderProfile>>(),
        );
        expect(h.telemetry.passed, 0);
        expect(h.telemetry.failed, 1);
        expect(h.cache.reads, 0);
        expect(h.cache.writes, 0);
      },
    );
  }
  for (final route in [
    '/v1/provider/profile',
    '/v1/provider/profile?probe=1',
    '/v1/provider/profile/',
    'https://api.example.test/v1/provider/profile?probe=1',
    'https://api.example.test/v1/provider/profile/?probe=1',
    '/v1/provider/dashboard',
    'https://api.example.test/v1/provider/dashboard/?probe=1',
  ]) {
    for (final status in <int?>[404, 503, null]) {
      test(
        'actual transport $route preserves $status without foreign-session cache or mock',
        () async {
          final h = Harness();
          addTearDown(h.close);
          h.failure(status);
          final response = await h.client.get(route);
          expect(response.statusCode, status ?? 503);
          expect(response.isSuccess, isFalse);
          expect(
            response.data,
            status == null ? isEmpty : {'error': 'Rejected profile'},
          );
          expect(h.cache.reads, 0);
          expect(h.cache.writes, 0);
        },
      );
    }
  }
  test(
    'real non-200 success status does not pass the profile contract gate',
    () async {
      final h = Harness();
      addTearDown(h.close);
      h.success({'profile': profile()}, status: 202);
      expect(await h.service.getSelfProfile(), isA<Failure<ProviderProfile>>());
      expect(h.telemetry.passed, 0);
      expect(h.telemetry.failed, 1);
    },
  );
}
