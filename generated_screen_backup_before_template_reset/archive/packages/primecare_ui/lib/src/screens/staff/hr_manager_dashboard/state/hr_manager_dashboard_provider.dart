import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_manager_dashboard_model.dart';

class HrManagerDashboardNotifier extends StateNotifier<HrManagerDashboardModel> {
  HrManagerDashboardNotifier() : super(const HrManagerDashboardModel(isLoading: true));

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

final hr_manager_dashboardProvider = StateNotifierProvider<HrManagerDashboardNotifier, HrManagerDashboardModel>((ref) {
  return HrManagerDashboardNotifier()..loadData();
});
