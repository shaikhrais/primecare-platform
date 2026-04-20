import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Central API client for all PrimeCare backend calls.
/// Uses HttpOnly cookie-based auth (same as web-admin).
class ApiClient {
  late final Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Default to the Cloudflare Worker API URL
  static const String _baseUrl = 'https://primecare-api.shaikhrais.workers.dev';

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Client': 'PrimeCarePSW-Flutter/1.0',
      },
    ),);

    // Request interceptor: attach stored auth token
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        // Auto-logout on 401
        if (error.response?.statusCode == 401) {
          await _storage.delete(key: 'auth_token');
          await _storage.delete(key: 'user_data');
        }
        handler.next(error);
      },
    ),);
  }

  // ── Auth ──
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _dio.post('/v1/auth/login', data: {
      'email': email,
      'password': password,
    },);
    final data = response.data;

    // Store token securely
    if (data['token'] != null) {
      await _storage.write(key: 'auth_token', value: data['token']);
    }
    return data;
  }

  Future<void> logout() async {
    try {
      await _dio.post('/v1/auth/logout');
    } catch (_) {}
    await _storage.delete(key: 'auth_token');
    await _storage.delete(key: 'user_data');
  }

  // ── Schedule ──
  Future<List<dynamic>> getTodaySchedule() async {
    final response = await _dio.get('/v1/psw/schedule/today');
    return response.data is List
        ? response.data
        : (response.data['shifts'] ?? []);
  }

  Future<Map<String, dynamic>> getVisitDetails(String visitId) async {
    final response = await _dio.get('/v1/psw/schedule/visits/$visitId');
    return response.data;
  }

  // ── Check-In/Out (EVV) ──
  Future<Map<String, dynamic>> checkIn({
    required String visitId,
    required double latitude,
    required double longitude,
  }) async {
    final response =
        await _dio.post('/v1/psw/schedule/visits/$visitId/check-in', data: {
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': DateTime.now().toIso8601String(),
    },);
    return response.data;
  }

  Future<Map<String, dynamic>> checkOut({
    required String visitId,
    required double latitude,
    required double longitude,
    String? notes,
  }) async {
    final response =
        await _dio.post('/v1/psw/schedule/visits/$visitId/check-out', data: {
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': DateTime.now().toIso8601String(),
      'notes': notes,
    },);
    return response.data;
  }

  // ── Incidents ──
  Future<Map<String, dynamic>> reportIncident({
    required String type,
    required String description,
    required String severity,
    String? visitId,
    double? latitude,
    double? longitude,
  }) async {
    final response = await _dio.post('/v1/psw/incidents', data: {
      'type': type,
      'description': description,
      'severity': severity,
      'visitId': visitId,
      'location': latitude != null
          ? {'latitude': latitude, 'longitude': longitude}
          : null,
      'timestamp': DateTime.now().toIso8601String(),
    },);
    return response.data;
  }

  // ── Profile ──
  Future<Map<String, dynamic>> getProfile() async {
    final response = await _dio.get('/v1/user/profile');
    return response.data;
  }
}

/// Global Riverpod provider for the API client
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());
