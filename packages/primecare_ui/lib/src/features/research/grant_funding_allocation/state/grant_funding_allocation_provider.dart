import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/grant_funding_allocation_model.dart';

class GrantFundingAllocationNotifier extends StateNotifier<GrantFundingAllocationModel> {
  GrantFundingAllocationNotifier() : super(const GrantFundingAllocationModel(isLoading: true));

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

final grant_funding_allocationProvider = StateNotifierProvider<GrantFundingAllocationNotifier, GrantFundingAllocationModel>((ref) {
  return GrantFundingAllocationNotifier()..loadData();
});
