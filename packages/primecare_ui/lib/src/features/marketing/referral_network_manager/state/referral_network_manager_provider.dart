import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/referral_network_manager_model.dart';

class ReferralNetworkManagerNotifier extends StateNotifier<ReferralNetworkManagerModel> {
  ReferralNetworkManagerNotifier() : super(const ReferralNetworkManagerModel(isLoading: true));

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

final referral_network_managerProvider = StateNotifierProvider<ReferralNetworkManagerNotifier, ReferralNetworkManagerModel>((ref) {
  return ReferralNetworkManagerNotifier()..loadData();
});
