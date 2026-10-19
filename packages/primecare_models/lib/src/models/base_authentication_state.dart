abstract class BaseAuthenticationState {
  final bool isAuthenticated;
  final bool isInitialized;
  final String? token;
  final String? role;
  final String? tenantId;
  final String? userName;
  final String? userId;

  final String? preferredLanguage;

  BaseAuthenticationState({
    this.isAuthenticated = false,
    this.isInitialized = false,
    this.token,
    this.role,
    this.tenantId,
    this.userName,
    this.userId,
    this.preferredLanguage,
  });

}
