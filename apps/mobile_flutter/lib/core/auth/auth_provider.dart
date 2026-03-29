import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final String? role;
  AuthState({this.role});
}

class AuthNotifier extends Notifier<AuthState> {
  final String initialRole;
  AuthNotifier([this.initialRole = 'psw_granular']);

  @override
  AuthState build() {
    return AuthState(role: initialRole);
  }

  void setRole(String role) => state = AuthState(role: role);
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
