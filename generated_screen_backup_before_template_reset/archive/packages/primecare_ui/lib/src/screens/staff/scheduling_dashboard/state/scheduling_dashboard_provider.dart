import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheduling_dashboard_model.dart';

class SchedulingDashboardNotifier extends StateNotifier<SchedulingDashboardModel> {
  SchedulingDashboardNotifier() : super(const SchedulingDashboardModel(isLoading: true));

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

final scheduling_dashboardProvider = StateNotifierProvider<SchedulingDashboardNotifier, SchedulingDashboardModel>((ref) {
  return SchedulingDashboardNotifier()..loadData();
});
