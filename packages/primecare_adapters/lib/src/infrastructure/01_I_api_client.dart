// Layer: 01_INFRASTRUCTURE
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '01_I_api_config.dart';
import '01_I_telemetry_service.dart';
import '01_I_circuit_breaker.dart';
import '01_I_retry_interceptor.dart';
import '01_I_resilience_mock_interceptor.dart';

/// Centralized API Client for the PrimeCare platform.
/// Handles network resilience, telemetry, and authenticated communication.
class ApiClient {
  final Ref _ref;
  late final Dio _dio;

  ApiClient(this._ref) {
    _initialize();
  }

  void _initialize() {
    _dio = Dio(
      BaseOptions(
        baseUrl: '${ApiConfig.baseUrl}/${ApiConfig.version}',
        connectTimeout: ApiConfig.timeout,
        receiveTimeout: ApiConfig.timeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Resilience Layer 1: Circuit Breaker
    _dio.interceptors.add(CircuitBreakerInterceptor());

    // Security & Auth Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          // Inject Tenant Context for Multi-tenant compliance
          try {
            final tenantId = prefs.getString('auth_tenant_id');
            if (tenantId != null) {
              options.headers['x-tenant-id'] = tenantId;
            }
          } catch (e) {
            // Silently continue if preference reading fails
          }

          return handler.next(options);
        },
      ),
    );

    // Telemetry & Monitoring
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _ref
              .read(executionGateProvider.notifier)
              .passGate(
                ExecutionGateCategory.network,
                'Request: ${options.method} ${options.path}',
              );
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _ref
              .read(executionGateProvider.notifier)
              .passGate(
                ExecutionGateCategory.network,
                'Response: ${response.statusCode} from ${response.requestOptions.path}',
              );
          return handler.next(response);
        },
        onError: (e, handler) {
          _ref
              .read(executionGateProvider.notifier)
              .failGate(
                ExecutionGateCategory.network,
                'Network Error: ${e.message}',
                error: e,
              );
          return handler.next(e);
        },
      ),
    );

    // Resilience Layer 2: Retry with Exponential Backoff
    _dio.interceptors.add(RetryInterceptor(dio: _dio));

    // Resilience Layer 3: Mock Fallbacks for problematic endpoints
    _dio.interceptors.add(ResilienceMockInterceptor(_ref));
  }

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    return _dio.get(path, queryParameters: query);
  }

  Future<Response<dynamic>> post(String path, {dynamic body}) async {
    return _dio.post(path, data: body);
  }

  Future<Response<dynamic>> put(String path, {dynamic body}) async {
    return _dio.put(path, data: body);
  }

  Future<Response<dynamic>> delete(String path, {dynamic body}) async {
    return _dio.delete(path, data: body);
  }
}

/// Global provider for the ApiClient.
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient(ref));
