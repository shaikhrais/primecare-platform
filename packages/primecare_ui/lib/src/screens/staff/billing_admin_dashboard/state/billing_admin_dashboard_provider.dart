import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/billing_admin_dashboard_model.dart';

class BillingAdminDashboardNotifier extends StateNotifier<BillingAdminDashboardModel> {
  BillingAdminDashboardNotifier() : super(const BillingAdminDashboardModel(isLoading: true));

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

final billing_admin_dashboardProvider = StateNotifierProvider<BillingAdminDashboardNotifier, BillingAdminDashboardModel>((ref) {
  return BillingAdminDashboardNotifier()..loadData();
});
