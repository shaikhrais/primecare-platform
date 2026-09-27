import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/forgot_password_model.dart';

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordModel> {
  ForgotPasswordNotifier() : super(const ForgotPasswordModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const {});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final forgot_passwordProvider = StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordModel>((ref) {
  return ForgotPasswordNotifier()..loadData();
});
