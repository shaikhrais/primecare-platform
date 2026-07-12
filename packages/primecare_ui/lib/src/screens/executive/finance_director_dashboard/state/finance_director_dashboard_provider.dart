import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/finance_director_dashboard_model.dart';

class FinanceDirectorDashboardNotifier extends StateNotifier<FinanceDirectorDashboardModel> {
  FinanceDirectorDashboardNotifier() : super(const FinanceDirectorDashboardModel(isLoading: true));

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

final finance_director_dashboardProvider = StateNotifierProvider<FinanceDirectorDashboardNotifier, FinanceDirectorDashboardModel>((ref) {
  return FinanceDirectorDashboardNotifier()..loadData();
});
