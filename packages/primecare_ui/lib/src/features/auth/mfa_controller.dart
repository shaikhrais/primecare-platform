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

    // Simulate API call
    await Future<void>.delayed(const Duration(seconds: 1));

    if (state.code == '123456') {
      state = state.copyWith(isLoading: false, isVerified: true);
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Invalid authentication code.',
      );
    }
  }
}

final mfaControllerProvider = NotifierProvider<MfaController, MfaState>(
  () => MfaController(),
);
