import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../security/security_interceptor.dart';

/// A provider for the [ApiClient], ensuring a single instance is used across the app.
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref);
});

/// A standardized API client for the PrimeCare platform using Dio.
class ApiClient {
  final Dio _dio;
  final Ref _ref;

  ApiClient(this._ref)
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiConfig.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'X-Requested-With': 'XMLHttpRequest',
          },
          extra: {'withCredentials': true},
        ),
      ) {
    _dio.interceptors.add(SecurityInterceptor(_ref));
  }

  /// Performs a GET request.
  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
      );
      return ApiResponse(
        data: response.data,
        statusCode: response.statusCode ?? 200,
      );
    } on DioException catch (e) {
      return ApiResponse(
        data: e.response?.data ?? <String, dynamic>{},
        statusCode: e.response?.statusCode ?? 500,
        error: e.message,
      );
    }
  }

  /// Performs a POST request.
  Future<ApiResponse> post(String path, {dynamic body}) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(path, data: body);
      return ApiResponse(
        data: response.data,
        statusCode: response.statusCode ?? 200,
      );
    } on DioException catch (e) {
      return ApiResponse(
        data: e.response?.data ?? <String, dynamic>{},
        statusCode: e.response?.statusCode ?? 500,
        error: e.message,
      );
    }
  }

  /// Performs a PUT request.
  Future<ApiResponse> put(String path, {dynamic body}) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(path, data: body);
      return ApiResponse(
        data: response.data,
        statusCode: response.statusCode ?? 200,
      );
    } on DioException catch (e) {
      return ApiResponse(
        data: e.response?.data ?? <String, dynamic>{},
        statusCode: e.response?.statusCode ?? 500,
        error: e.message,
      );
    }
  }

  /// Performs a DELETE request.
  Future<ApiResponse> delete(String path) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(path);
      return ApiResponse(
        data: response.data,
        statusCode: response.statusCode ?? 200,
      );
    } on DioException catch (e) {
      return ApiResponse(
        data: e.response?.data ?? <String, dynamic>{},
        statusCode: e.response?.statusCode ?? 500,
        error: e.message,
      );
    }
  }
}

/// A standardized response object for the [ApiClient].
class ApiResponse {
  final dynamic data;
  final int statusCode;
  final String? error;

  ApiResponse({required this.data, required this.statusCode, this.error});

  bool get isSuccess => statusCode >= 200 && statusCode < 300;
}

/// Centralized configuration for API endpoints and base URL.
class ApiConfig {
  static const String baseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8700');

  static const Map<String, String> endpoints = {
    'login': '/v1/auth/login',
    'register': '/v1/auth/register',
    'me': '/v1/auth/me',
    'dashboard-metrics': '/v1/governance/dashboard',
    'providerDashboard': '/v1/provider/dashboard',
    'providerCheckin': '/v1/provider/checkin',
    'verificationPurposeReport': '/v1/verification/purpose-report',
    'verificationDatabaseReport': '/v1/verification/database-report',
    'systemPermissions': '/v1/system/permissions',
    'adminStaffProvision': '/v1/admin/staff-provision',
    'adminAuditOverride': '/v1/admin/audit-override',
    'officePartnershipLeadsView': '/v1/office/partnership-leads',
    'providerMetrics': '/v1/provider/metrics',
  };
}
