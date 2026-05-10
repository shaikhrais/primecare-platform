import 'package:primecare_ui/primecare_ui.dart';

/// Immutable state for the Login feature.
class LoginState {
  final String email;
  final String password;
  final bool isLoading;
  final String? errorMessage;

  const LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.errorMessage,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// Controller responsible for authentication logic and state management.
/// Follows the 'No-Logic UI' principle by owning all business state.
class LoginController extends Notifier<LoginState> {
  @override
  LoginState build() {
    return const LoginState();
  }

  /// Updates the email in the state.
  void onEmailChanged(String value) {
    state = state.copyWith(email: value, clearError: true);
  }

  /// Updates the password in the state.
  void onPasswordChanged(String value) {
    state = state.copyWith(password: value, clearError: true);
  }

  /// Executes the login sequence using current state.
  Future<void> login() async {
    final email = state.email.trim();
    final password = state.password.trim();

    if (email.isEmpty || password.isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter both credentials.');
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final success = await ref
          .read(authProvider.notifier)
          .login(email, password);

      if (!success) {
        state = state.copyWith(
          isLoading: false,
          errorMessage:
              'Authentication failed. Please verify your credentials.',
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'A connection error occurred. Please try again.',
      );
    }
  }

  /// Injects demo credentials and attempts login.
  void loginWithDemo() {
    state = state.copyWith(email: 'admin@demo.primecare.com', password: 'demo');
    login();
  }
}

final loginControllerProvider = NotifierProvider<LoginController, LoginState>(
  () => LoginController(),
);
