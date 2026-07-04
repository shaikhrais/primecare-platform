import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/partnership_manager_active_deals_model.dart';

class PartnershipManagerActiveDealsNotifier extends StateNotifier<PartnershipManagerActiveDealsModel> {
  PartnershipManagerActiveDealsNotifier() : super(const PartnershipManagerActiveDealsModel(isLoading: true));

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

final partnership_manager_active_dealsProvider = StateNotifierProvider<PartnershipManagerActiveDealsNotifier, PartnershipManagerActiveDealsModel>((ref) {
  return PartnershipManagerActiveDealsNotifier()..loadData();
});
