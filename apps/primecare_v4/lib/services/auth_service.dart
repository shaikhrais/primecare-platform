import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthState {
  final bool isAuthenticated;
  final String? token;
  final String? role;

  AuthState({this.isAuthenticated = false, this.token, this.role});

  AuthState copyWith({bool? isAuthenticated, String? token, String? role}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
      role: role ?? this.role,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> implements Listenable {
  String get _baseUrl => dotenv.env['API_URL'] ?? 'https://primecare-api.itpro-mohammed.workers.dev';
  final List<VoidCallback> _listeners = [];

  AuthNotifier() : super(AuthState()) {
    _loadStoredAuth();
  }

  static String getDashboardRouteForRole(String role) {
    if (role.isEmpty) return '/'; // Default fallback
    
    // Normalize role string to match route constants from app_routes
    final normalized = role.toLowerCase().replaceAll(' ', '_').replaceAll('/', '_');
    
    // Detailed mapping based on exact user roles:
    if (normalized.contains('founder') || normalized.contains('ceo')) return '/office/corporate/founder_ceo';
    if (normalized.contains('psw')) return '/office/clinical/psw';
    if (normalized.contains('admin')) return '/office/franchise/billing_admin';
    if (normalized.contains('rn')) return '/office/clinical/rn';
    // Fallback logic
    return '/office/clinical/psw'; // Generic fallback
  }

  Future<void> _loadStoredAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final role = prefs.getString('auth_role');
    if (token != null && role != null) {
      state = state.copyWith(isAuthenticated: true, token: token, role: role);
      _notifyListeners();
    }
  }

  @override
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      // We also maintain mock logic for easy visual testing if API fails
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'] ?? 'mock-token';
        final role = data['role'] ?? 'PSW'; // Fallback
        
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('auth_role', role);

        state = state.copyWith(isAuthenticated: true, token: token, role: role);
        _notifyListeners();
        return true;
      } else {
        // Mock fallback for current development without active API routes
        if (email == 'admin@primecare.com') {
           state = state.copyWith(isAuthenticated: true, token: 'mock-token', role: 'Admin');
           _notifyListeners();
           return true;
        } else if (email.isNotEmpty && password.isNotEmpty) {
           state = state.copyWith(isAuthenticated: true, token: 'mock-token', role: 'PSW');
           _notifyListeners();
           return true;
        }
      }
    } catch (e) {
      // Mock fallback
      if (email == 'admin@primecare.com') {
         state = state.copyWith(isAuthenticated: true, token: 'mock-token', role: 'Admin');
         _notifyListeners();
         return true;
      } else if (email.isNotEmpty && password.isNotEmpty) {
         state = state.copyWith(isAuthenticated: true, token: 'mock-token', role: 'PSW');
         _notifyListeners();
         return true;
      }
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('auth_role');
    state = AuthState();
    _notifyListeners();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
