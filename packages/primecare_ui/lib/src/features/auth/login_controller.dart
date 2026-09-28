// Governance - Category: controller | Purpose: Immutable state for the Login feature.
import 'package:primecare_ui/primecare_ui.dart';

/// Immutable state for the Login feature.
class LoginState {
  final String email;
  final String password;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  const LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccess ? null : (successMessage ?? this.successMessage),
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
    if (state.isLoading) return;
    final email = state.email.trim();
    final password = state.password;

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

  /// Executes the forgot password sequence.
  Future<bool> forgotPassword(String targetEmail) async {
    final email = targetEmail.trim();

    if (email.isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your email.');
      return false;
    }

    state = state.copyWith(isLoading: true, clearError: true, clearSuccess: true);

    try {
      final success = await ref
          .read(authProvider.notifier)
          .forgotPassword(email);

      if (!success) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to send password reset link. Please verify your email.',
        );
        return false;
      } else {
        state = state.copyWith(
          isLoading: false,
          successMessage: 'Password reset link sent to $email.',
        );
        return true;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'A connection error occurred. Please try again.',
      );
      return false;
    }
  }

  /// Injects demo credentials and attempts login.
  void loginWithDemo() {
    state = state.copyWith(email: 'admin@demo.primecare.com', password: 'demo');
    login();
  }

  /// Prefill the login form with test credentials.
  void prefillCredentials(String email, String password) {
    state = state.copyWith(email: email, password: password, clearError: true);
  }

  /// Automatically prefill and login using test credentials.
  void loginWithTestCredential(String email, String password) {
    state = state.copyWith(email: email, password: password, clearError: true);
    login();
  }

  /// Simulates a login for a specific role (Development/Demo only).
  Future<void> simulateLogin(String role) async {
    state = state.copyWith(isLoading: true, clearError: true);
    // Simulate API delay
    await Future<void>.delayed(const Duration(milliseconds: 800));

    try {
      // Injects the role directly into the session via the auth provider
      await ref.read(authProvider.notifier).simulateRoleSession(role);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Simulation failed: $e',
      );
    }
  }
}

final loginControllerProvider = NotifierProvider<LoginController, LoginState>(
  () => LoginController(),
);
