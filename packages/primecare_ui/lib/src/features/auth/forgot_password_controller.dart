// Governance - Category: controller | Purpose: Controller layer orchestrating business logic and state management for the corresponding module.
import 'package:primecare_ui/primecare_ui.dart';

class ForgotPasswordState {
  final String email;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const ForgotPasswordState({
    this.email = '',
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  ForgotPasswordState copyWith({
    String? email,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    bool clearError = false,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class ForgotPasswordController extends Notifier<ForgotPasswordState> {
  @override
  ForgotPasswordState build() {
    return const ForgotPasswordState();
  }

  void onEmailChanged(String value) {
    state = state.copyWith(email: value, clearError: true);
  }

  Future<void> submit() async {
    if (state.email.isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your email address.');
      return;
    }
    state = state.copyWith(isLoading: true, clearError: true);

    // Simulate API call
    await Future<void>.delayed(const Duration(seconds: 1));

    state = state.copyWith(isLoading: false, isSuccess: true);
  }
}

final forgotPasswordControllerProvider =
    NotifierProvider<ForgotPasswordController, ForgotPasswordState>(
      () => ForgotPasswordController(),
    );
