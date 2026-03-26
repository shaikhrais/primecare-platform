import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final String? role;
  AuthState({this.role});
}

// Lightweight mirror to satisfy RoleSowScreen dependencies following systemic refactoring
final authProvider = Provider<AuthState>((ref) => AuthState(role: 'psw'));
