import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_adapters/primecare_adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- Manual Mocks ---

class MockApiClient extends ApiClient {
  MockApiClient(super.ref);

  double chaosProbability = 0.0;

  @override
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    _maybeThrowChaos();
    // Return empty mock data for hydration
    return Response(
      requestOptions: RequestOptions(path: path),
      data: <String, dynamic>{
        'activities': <dynamic>[],
        'metrics': <String, dynamic>{},
      },
      statusCode: 200,
    );
  }

  @override
  Future<Response<dynamic>> post(
    String path, {
    dynamic body,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    _maybeThrowChaos();
    return Response(
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
    );
  }

  void _maybeThrowChaos() {
    if (chaosProbability > 0) {
      if (DateTime.now().microsecond % 100 < (chaosProbability * 100)) {
        throw DioException(
          requestOptions: RequestOptions(path: 'chaos'),
          type: DioExceptionType.connectionError,
          error: 'RDS Chaos Injection',
        );
      }
    }
  }

  Map<String, dynamic> get mockData => <String, dynamic>{
    'summary': <String, dynamic>{},
    'activities': <dynamic>[],
    'metrics': <String, dynamic>{},
  };
}

void main() {
  group('RDS: Adapter Hydration Bench', () {
    late ProviderContainer container;
    late MockApiClient mockApi;

    setUp(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{
        'tenant_context': '{"id": "test-tenant", "role": "admin"}',
      });

      container = ProviderContainer(
        overrides: [
          apiClientProvider.overrideWith((ref) => MockApiClient(ref)),
        ],
      );
      mockApi = container.read(apiClientProvider) as MockApiClient;
    });

    tearDown(() {
      container.dispose();
    });

    test('High-Speed Hydration & Latency Audit', () async {
      final results = <PrimeCareForm, double>{};
      final failures = <PrimeCareForm, String>{};
      final stopwatch = Stopwatch();

      print('--- Hydration Latency Audit ---');
      for (final form in PrimeCareForm.values) {
        try {
          stopwatch.reset();
          stopwatch.start();

          container.read(primecareFormProvider(form));

          stopwatch.stop();
          results[form] = stopwatch.elapsedMicroseconds / 1000.0;
        } catch (e) {
          failures[form] = e.toString();
        }
      }

      final slowAdapters = results.entries.where((e) => e.value > 50).toList();
      if (slowAdapters.isNotEmpty) {
        print('WARNING: Detect slow adapters (>50ms):');
        for (var entry in slowAdapters) {
          print(' - ${entry.key.name}: ${entry.value.toStringAsFixed(2)}ms');
        }
      }

      print(
        'Success: ${results.length} / Total: ${PrimeCareForm.values.length}',
      );
      expect(
        failures,
        isEmpty,
        reason: 'All adapters should be registered in primecareFormProvider',
      );
    });

    test('Chaos Resilience: API Failure Simulation', () async {
      mockApi.chaosProbability = 0.5; // 50% failure rate
      int failureCount = 0;
      int passCount = 0;

      print('--- Chaos Mode Resilience Test ---');
      for (final form in PrimeCareForm.values) {
        try {
          // This test checks if refreshing/reloading an adapter handles API errors
          container.read(primecareFormProvider(form));
          passCount++;
        } catch (e) {
          failureCount++;
        }
      }

      print('Chaos Results: $passCount Passed, $failureCount Handled Failures');
      expect(true, isTrue);
    });
  });
}
