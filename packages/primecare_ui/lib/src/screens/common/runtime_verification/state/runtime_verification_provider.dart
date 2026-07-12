import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/runtime_verification_model.dart';

class RuntimeVerificationNotifier extends StateNotifier<RuntimeVerificationModel> {
  RuntimeVerificationNotifier() : super(const RuntimeVerificationModel(isLoading: true));

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

final runtime_verificationProvider = StateNotifierProvider<RuntimeVerificationNotifier, RuntimeVerificationModel>((ref) {
  return RuntimeVerificationNotifier()..loadData();
});
