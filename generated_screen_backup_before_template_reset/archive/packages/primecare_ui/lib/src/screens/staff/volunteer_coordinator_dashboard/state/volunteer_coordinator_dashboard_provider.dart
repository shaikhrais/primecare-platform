import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/volunteer_coordinator_dashboard_model.dart';

class VolunteerCoordinatorDashboardNotifier extends StateNotifier<VolunteerCoordinatorDashboardModel> {
  VolunteerCoordinatorDashboardNotifier() : super(const VolunteerCoordinatorDashboardModel(isLoading: true));

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

final volunteer_coordinator_dashboardProvider = StateNotifierProvider<VolunteerCoordinatorDashboardNotifier, VolunteerCoordinatorDashboardModel>((ref) {
  return VolunteerCoordinatorDashboardNotifier()..loadData();
});
