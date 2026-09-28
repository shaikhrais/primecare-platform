// Governance - Category: controller | Purpose: Controller layer orchestrating business logic and state management for the corresponding module.
import 'package:primecare_ui/primecare_ui.dart';

class MfaState {
  final String code;
  final bool isLoading;
  final String? errorMessage;
  final bool isVerified;

  const MfaState({
    this.code = '',
    this.isLoading = false,
    this.errorMessage,
    this.isVerified = false,
  });

  MfaState copyWith({
    String? code,
    bool? isLoading,
    String? errorMessage,
    bool? isVerified,
    bool clearError = false,
  }) {
    return MfaState(
      code: code ?? this.code,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isVerified: isVerified ?? this.isVerified,
    );
  }
}

class MfaController extends Notifier<MfaState> {
  @override
  MfaState build() {
    return const MfaState();
  }

  void onCodeChanged(String value) {
    state = state.copyWith(code: value, clearError: true);
  }

  Future<void> verify() async {
    if (state.code.length < 6) {
      state = state.copyWith(
        errorMessage: 'Please enter a valid 6-digit code.',
      );
      return;
    }
    state = state.copyWith(isLoading: true, clearError: true);

    // Fail closed until the central service provides a verified recovery/challenge contract.
    state = state.copyWith(
      isLoading: false,
      isVerified: false,
      errorMessage: 'auth_flow_unavailable'.tr(),
    );
  }
}

final mfaControllerProvider = NotifierProvider<MfaController, MfaState>(
  () => MfaController(),
);
