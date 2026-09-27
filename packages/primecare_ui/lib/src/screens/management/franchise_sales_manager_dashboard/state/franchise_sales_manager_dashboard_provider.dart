import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_sales_manager_dashboard_model.dart';

class FranchiseSalesManagerDashboardNotifier extends StateNotifier<FranchiseSalesManagerDashboardModel> {
  FranchiseSalesManagerDashboardNotifier() : super(const FranchiseSalesManagerDashboardModel(isLoading: true));

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

final franchise_sales_manager_dashboardProvider = StateNotifierProvider<FranchiseSalesManagerDashboardNotifier, FranchiseSalesManagerDashboardModel>((ref) {
  return FranchiseSalesManagerDashboardNotifier()..loadData();
});
