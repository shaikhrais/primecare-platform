import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cto_system_verification_model.dart';

class CtoSystemVerificationNotifier extends StateNotifier<CtoSystemVerificationModel> {
  CtoSystemVerificationNotifier() : super(const CtoSystemVerificationModel(isLoading: true));

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

final cto_system_verificationProvider = StateNotifierProvider<CtoSystemVerificationNotifier, CtoSystemVerificationModel>((ref) {
  return CtoSystemVerificationNotifier()..loadData();
});
