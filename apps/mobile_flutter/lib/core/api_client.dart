import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'database/sqlite_database_helper.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  // Mobile Android Emulator bypasses DNS limits using Loopback bindings
  static const String baseUrl =
      'https://primecare-api.itpro-mohammed.workers.dev';

  final _secureStorage = const FlutterSecureStorage();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _secureStorage.read(key: 'auth_token');
    final cookie = await _secureStorage.read(key: 'auth_cookie');
    
    // Purge legacy plaintext configs natively
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('auth_token')) {
      print('🔒 [SECURE ENCLAVE] Purging legacy plaintext authentication.');
      await prefs.remove('auth_token');
      await prefs.remove('auth_cookie');
      return {}; // Force re-login automatically
    }

    return {
      'Content-Type': 'application/json',
      'Accept-Language': 'fr',
      'X-Requested-With': 'Flutter_Client',
      if (token != null) 'Authorization': 'Bearer $token',
      'Cookie': cookie ?? '',
    };
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final headers = await _getHeaders();
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Server returned ${response.statusCode}');
      }
    } catch (e) {
      print(
        '🌐 [OFFLINE CRDT BUFFER] Connection dropped. Intercepting POST $endpoint.',
      );
      if (!kIsWeb) {
        await SqliteDatabaseHelper.instance.insertPayload({
          'id': Uuid().v4(),
          'httpMethod': 'POST',
          'endpointUrl': endpoint,
          'jsonPayload': jsonEncode(body),
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          'retryCount': 0,
        });
      }
      return {
        'success': true,
        'offline_queued': true,
        'message': 'Saved locally. Will sync when online.',
      };
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final headers = await _getHeaders();
    try {
      final response = await _client.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Server returned ${response.statusCode}');
      }
    } catch (e) {
      print(
        '🌐 [OFFLINE CRDT BUFFER] Connection dropped. Intercepting PUT $endpoint.',
      );
      if (!kIsWeb) {
        await SqliteDatabaseHelper.instance.insertPayload({
          'id': Uuid().v4(),
          'httpMethod': 'PUT',
          'endpointUrl': endpoint,
          'jsonPayload': jsonEncode(body),
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          'retryCount': 0,
        });
      }
      return {
        'success': true,
        'offline_queued': true,
        'message': 'Profile Update saved offline. Will sync when online.',
      };
    }
  }

  Future<dynamic> patch(String endpoint, Map<String, dynamic> body) async {
    final headers = await _getHeaders();
    final response = await _client.patch(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Server returned ${response.statusCode}');
    }
  }

  Future<dynamic> delete(String endpoint) async {
    final headers = await _getHeaders();
    final response = await _client.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return {'success': true};
      return jsonDecode(response.body);
    } else {
      throw Exception('Server returned ${response.statusCode}');
    }
  }

  Future<dynamic> get(String endpoint) async {
    final headers = await _getHeaders();
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (!kIsWeb) {
           await SqliteDatabaseHelper.instance.cacheEndpointData(endpoint, response.body);
        } else {
           // On web Sqlite_ffi handles it now
           await SqliteDatabaseHelper.instance.cacheEndpointData(endpoint, response.body);
        }
        return jsonDecode(response.body);
      } else {
        throw Exception('Server returned ${response.statusCode}');
      }
    } catch (e) {
      print('🌐 [OFFLINE CACHE HIT] Connection dropped. Intercepting GET $endpoint.');
      final cachedJson = await SqliteDatabaseHelper.instance.getCachedEndpointData(endpoint);
      if (cachedJson != null) {
        return jsonDecode(cachedJson);
      }
      return {'success': true, 'mocked': true, 'offline': true, 'data': {}};
    }
  }

  Future<void> login(String email, String password) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/v1/auth/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept-Language': 'fr',
        'X-Requested-With': 'Flutter_Client',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      final rawCookie = response.headers['set-cookie'];
      String? sessionCookie;

      if (rawCookie != null) {
        final match = RegExp(r'accessToken=([^;]+)').firstMatch(rawCookie);
        if (match != null) {
          sessionCookie = 'accessToken=${match.group(1)}';
        }
      }

      if (data['user'] != null && data['token'] != null) {
        await _secureStorage.write(key: 'auth_token', value: data['token']);

        final roles = data['user']['roles'] as List<dynamic>? ?? [];
        String primaryRole = 'psw_granular';

        if (data['user']['primaryRole'] != null) {
          primaryRole = data['user']['primaryRole'].toString();
        } else if (roles.isNotEmpty) {
          primaryRole = roles.first.toString();
        }

        await _secureStorage.write(key: 'user_role', value: primaryRole);

        if (sessionCookie != null) {
          await _secureStorage.write(key: 'auth_cookie', value: sessionCookie);
        }
      } else {
        throw Exception('Invalid Credentials or Token Payload');
      }
    } else {
      throw Exception('API Error: ${response.statusCode} - ${response.body}');
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'auth_token');
    await _secureStorage.delete(key: 'user_role');
    await _secureStorage.delete(key: 'auth_cookie');
  }
}

final apiClient = ApiClient();
