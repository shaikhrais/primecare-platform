import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/referral_management_model.dart';

class ReferralManagementNotifier extends StateNotifier<ReferralManagementModel> {
  ReferralManagementNotifier() : super(const ReferralManagementModel(isLoading: true));

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

final referral_managementProvider = StateNotifierProvider<ReferralManagementNotifier, ReferralManagementModel>((ref) {
  return ReferralManagementNotifier()..loadData();
});
