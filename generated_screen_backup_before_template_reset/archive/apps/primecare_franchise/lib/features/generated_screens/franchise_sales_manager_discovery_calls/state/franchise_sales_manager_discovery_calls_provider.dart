import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_sales_manager_discovery_calls_model.dart';

class FranchiseSalesManagerDiscoveryCallsNotifier extends StateNotifier<FranchiseSalesManagerDiscoveryCallsModel> {
  FranchiseSalesManagerDiscoveryCallsNotifier() : super(const FranchiseSalesManagerDiscoveryCallsModel(isLoading: true));

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

final franchise_sales_manager_discovery_callsProvider = StateNotifierProvider<FranchiseSalesManagerDiscoveryCallsNotifier, FranchiseSalesManagerDiscoveryCallsModel>((ref) {
  return FranchiseSalesManagerDiscoveryCallsNotifier()..loadData();
});
