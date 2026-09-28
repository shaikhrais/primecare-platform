import 'package:flutter_riverpod/legacy.dart';
import '../models/franchise_owner_dashboard_model.dart';

class FranchiseOwnerDashboardNotifier extends StateNotifier<FranchiseOwnerDashboardModel> {
  FranchiseOwnerDashboardNotifier() : super(const FranchiseOwnerDashboardModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final franchise_owner_dashboardProvider = StateNotifierProvider<FranchiseOwnerDashboardNotifier, FranchiseOwnerDashboardModel>((ref) {
  return FranchiseOwnerDashboardNotifier()..loadData();
});
