import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

class AuthState {
  final bool isAuthenticated;
  final String? roleId;
  final String? userName;
  final String? token;

  const AuthState({
    required this.isAuthenticated,
    this.roleId,
    this.userName,
    this.token,
  });

  factory AuthState.unauthenticated() => const AuthState(isAuthenticated: false);
  factory AuthState.authenticated(String roleId, String userName, String token) => 
      AuthState(isAuthenticated: true, roleId: roleId, userName: userName, token: token);
}

class AuthNotifier extends Notifier<AuthState> {
  static const String baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://127.0.0.1:8787',
  );

  @override
  AuthState build() => AuthState.unauthenticated();

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final user = data['user'];
        final rawRoles = user['roles'] as List;
        final roleId = rawRoles.isNotEmpty ? rawRoles.first.toString().toLowerCase().trim() : 'founder_ceo';
        final userName = user['email'] as String;

        state = AuthState.authenticated(roleId, userName, token);
      } else {
        final data = jsonDecode(response.body);
        final error = data['message'] ?? data['error'] ?? 'Authentication failed. Incorrect email or password.';
        throw Exception(error);
      }
    } catch (e) {
      if (e is Exception && e.toString().contains('Exception:')) {
        rethrow;
      }
      throw Exception('Network error connecting to $baseUrl');
    }
  }

  void logout() {
    state = AuthState.unauthenticated();
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
