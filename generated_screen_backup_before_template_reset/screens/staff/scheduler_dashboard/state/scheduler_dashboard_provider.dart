import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheduler_dashboard_model.dart';

class SchedulerDashboardNotifier extends StateNotifier<SchedulerDashboardModel> {
  SchedulerDashboardNotifier() : super(const SchedulerDashboardModel(isLoading: true));

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

final scheduler_dashboardProvider = StateNotifierProvider<SchedulerDashboardNotifier, SchedulerDashboardModel>((ref) {
  return SchedulerDashboardNotifier()..loadData();
});
