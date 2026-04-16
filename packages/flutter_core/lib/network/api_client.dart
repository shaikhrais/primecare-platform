import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';
import '../telemetry_service.dart';
import '../auth_service.dart';
import 'circuit_breaker.dart';
import 'retry_interceptor.dart';

class ApiClient {
  final Ref _ref;
  late final Dio _dio;

  ApiClient(this._ref) {
    _initialize();
  }

  ApiClient.internal(this._ref);

  void _initialize() {
    _dio = Dio(
      BaseOptions(
        baseUrl: '${ApiConfig.baseUrl}/${ApiConfig.version}',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
        },
      ),
    );

    // Resilience Layer 1: Circuit Breaker (blocks requests when backend is unhealthy)
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
          return handler.next(options);
        },
      ),
    );

    // Resilience Layer 1.5: 401 Auth Recovery (detects expired tokens)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            // Token is expired or invalid — clear stored auth and force re-login
            final prefs = await SharedPreferences.getInstance();
            await prefs.remove('auth_token');
            await prefs.remove('auth_role');
            await prefs.remove('auth_tenant_id');
            // Trigger GoRouter redirect to login via the global listenable
            authListenable.value = false;
            _ref
                .read(executionGateProvider)
                .failGate(
                  ExecutionGateCategory.auth,
                  'Token expired or rejected (401). Session invalidated, redirecting to login.',
                  error: e,
                  metadata: {'path': e.requestOptions.path, 'statusCode': 401},
                );
          }
          return handler.next(e);
        },
      ),
    );

    // PrimeCare Telemetry Execution Gate Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _ref
              .read(executionGateProvider)
              .passGate(
                ExecutionGateCategory.network,
                'Request Initiated: [${options.method}] ${options.path}',
                metadata: {
                  'path': options.path,
                  'method': options.method,
                  'baseUrl': options.baseUrl,
                },
              );
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _ref
              .read(executionGateProvider)
              .passGate(
                ExecutionGateCategory.network,
                'Response Received: ${response.statusCode} from ${response.requestOptions.path}',
                metadata: {
                  'statusCode': response.statusCode,
                  'path': response.requestOptions.path,
                  'latencyMs': response.headers['x-response-time'] ?? 'unknown',
                },
              );
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          _ref
              .read(executionGateProvider)
              .failGate(
                ExecutionGateCategory.network,
                'Network Error: ${e.type} on ${e.requestOptions.path}',
                error: e,
                stackTrace: e.stackTrace,
                metadata: {
                  'type': e.type.toString(),
                  'statusCode': e.response?.statusCode,
                  'path': e.requestOptions.path,
                  'message': e.message,
                },
              );
          return handler.next(e);
        },
      ),
    );

    // Resilience Layer 2: Retry with Exponential Backoff (transient GET failures only)
    _dio.interceptors.add(RetryInterceptor(dio: _dio));

    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    return _dio.get(path, queryParameters: query);
  }

  Future<Response> post(String path, {dynamic body}) async {
    return _dio.post(path, data: body);
  }

  Future<Response> put(String path, {dynamic body}) async {
    return _dio.put(path, data: body);
  }

  Future<Response> delete(String path, {dynamic body}) async {
    return _dio.delete(path, data: body);
  }
}
