import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/financial_dashboard_model.dart';

class FinancialDashboardNotifier extends StateNotifier<FinancialDashboardModel> {
  FinancialDashboardNotifier() : super(const FinancialDashboardModel(isLoading: true));

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

final financial_dashboardProvider = StateNotifierProvider<FinancialDashboardNotifier, FinancialDashboardModel>((ref) {
  return FinancialDashboardNotifier()..loadData();
});
