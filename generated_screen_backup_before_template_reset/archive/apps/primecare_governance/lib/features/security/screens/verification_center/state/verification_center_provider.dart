import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/verification_center_model.dart';

class VerificationCenterNotifier extends StateNotifier<VerificationCenterModel> {
  VerificationCenterNotifier() : super(const VerificationCenterModel(isLoading: true));

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

final verification_centerProvider = StateNotifierProvider<VerificationCenterNotifier, VerificationCenterModel>((ref) {
  return VerificationCenterNotifier()..loadData();
});
