import 'package:primecare_ui/primecare_ui.dart';

class ResetPasswordState {
  final String newPassword;
  final String confirmPassword;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const ResetPasswordState({
    this.newPassword = '',
    this.confirmPassword = '',
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  ResetPasswordState copyWith({
    String? newPassword,
    String? confirmPassword,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    bool clearError = false,
  }) {
    return ResetPasswordState(
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class ResetPasswordController extends Notifier<ResetPasswordState> {
  @override
  ResetPasswordState build() {
    return const ResetPasswordState();
  }

  void onNewPasswordChanged(String value) {
    state = state.copyWith(newPassword: value, clearError: true);
  }

  void onConfirmPasswordChanged(String value) {
    state = state.copyWith(confirmPassword: value, clearError: true);
  }

  Future<void> submit() async {
    if (state.newPassword.isEmpty || state.confirmPassword.isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter both fields.');
      return;
    }
    if (state.newPassword != state.confirmPassword) {
      state = state.copyWith(errorMessage: 'Passwords do not match.');
      return;
    }
    state = state.copyWith(isLoading: true, clearError: true);

    // Simulate API call
    await Future<void>.delayed(const Duration(seconds: 1));

    state = state.copyWith(isLoading: false, isSuccess: true);
  }
}

final resetPasswordControllerProvider =
    NotifierProvider<ResetPasswordController, ResetPasswordState>(
      () => ResetPasswordController(),
    );
