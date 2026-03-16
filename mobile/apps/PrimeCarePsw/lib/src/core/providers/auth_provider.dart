import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Authentication state — tracks logged-in user and token
class AuthState {
  final bool isAuthenticated;
  final Map<String, dynamic>? user;
  final bool isLoading;

  const AuthState({
    this.isAuthenticated = false,
    this.user,
    this.isLoading = true,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    Map<String, dynamic>? user,
    bool? isLoading,
  }) => AuthState(
    isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    user: user ?? this.user,
    isLoading: isLoading ?? this.isLoading,
  );

  String get email => user?['email'] ?? '';
  String get fullName => user?['profile']?['fullName'] ?? email;
  String get activeRole => user?['activeRole'] ?? 'psw';
  List<String> get roles => List<String>.from(user?['roles'] ?? []);
}

/// Auth state notifier — manages login/logout with secure storage
class AuthNotifier extends StateNotifier<AuthState> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthNotifier() : super(const AuthState()) {
    _loadSavedSession();
  }

  Future<void> _loadSavedSession() async {
    final userData = await _storage.read(key: 'user_data');
    final token = await _storage.read(key: 'auth_token');

    if (userData != null && token != null) {
      state = AuthState(
        isAuthenticated: true,
        user: jsonDecode(userData),
        isLoading: false,
      );
    } else {
      state = const AuthState(isAuthenticated: false, isLoading: false);
    }
  }

  Future<void> loginSuccess(Map<String, dynamic> responseData) async {
    final user = responseData['user'] ?? responseData;
    await _storage.write(key: 'user_data', value: jsonEncode(user));
    state = AuthState(
      isAuthenticated: true,
      user: user,
      isLoading: false,
    );
  }

  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
    await _storage.delete(key: 'user_data');
    state = const AuthState(isAuthenticated: false, isLoading: false);
  }
}

/// Global auth state provider
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
