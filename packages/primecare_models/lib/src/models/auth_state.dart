import 'base_authentication_state.dart';

class AuthState extends BaseAuthenticationState {
  AuthState({
    super.isAuthenticated,
    super.isInitialized,
    super.token,
    super.role,
    super.tenantId,
    super.userName,
    super.userId,
    super.preferredLanguage,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isInitialized,
    String? token,
    String? role,
    String? tenantId,
    String? userName,
    String? userId,
    String? preferredLanguage,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isInitialized: isInitialized ?? this.isInitialized,
      token: token ?? this.token,
      role: role ?? this.role,
      tenantId: tenantId ?? this.tenantId,
      userName: userName ?? this.userName,
      userId: userId ?? this.userId,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
    );
  }
}
