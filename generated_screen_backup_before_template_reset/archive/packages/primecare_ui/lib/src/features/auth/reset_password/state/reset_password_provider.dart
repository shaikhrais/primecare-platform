import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/reset_password_model.dart';

class ResetPasswordNotifier extends StateNotifier<ResetPasswordModel> {
  ResetPasswordNotifier() : super(const ResetPasswordModel(isLoading: true));

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

final reset_passwordProvider = StateNotifierProvider<ResetPasswordNotifier, ResetPasswordModel>((ref) {
  return ResetPasswordNotifier()..loadData();
});
