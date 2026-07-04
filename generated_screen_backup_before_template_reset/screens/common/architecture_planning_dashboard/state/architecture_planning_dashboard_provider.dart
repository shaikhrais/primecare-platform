import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/architecture_planning_dashboard_model.dart';

class ArchitecturePlanningDashboardNotifier extends StateNotifier<ArchitecturePlanningDashboardModel> {
  ArchitecturePlanningDashboardNotifier() : super(const ArchitecturePlanningDashboardModel(isLoading: true));

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

final architecture_planning_dashboardProvider = StateNotifierProvider<ArchitecturePlanningDashboardNotifier, ArchitecturePlanningDashboardModel>((ref) {
  return ArchitecturePlanningDashboardNotifier()..loadData();
});
