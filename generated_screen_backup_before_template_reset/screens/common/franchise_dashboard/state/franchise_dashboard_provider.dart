import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_dashboard_model.dart';

class FranchiseDashboardNotifier extends StateNotifier<FranchiseDashboardModel> {
  FranchiseDashboardNotifier() : super(const FranchiseDashboardModel(isLoading: true));

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

final franchise_dashboardProvider = StateNotifierProvider<FranchiseDashboardNotifier, FranchiseDashboardModel>((ref) {
  return FranchiseDashboardNotifier()..loadData();
});
