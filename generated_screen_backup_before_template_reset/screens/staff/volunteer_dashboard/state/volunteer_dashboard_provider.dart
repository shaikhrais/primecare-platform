import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/volunteer_dashboard_model.dart';

class VolunteerDashboardNotifier extends StateNotifier<VolunteerDashboardModel> {
  VolunteerDashboardNotifier() : super(const VolunteerDashboardModel(isLoading: true));

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

final volunteer_dashboardProvider = StateNotifierProvider<VolunteerDashboardNotifier, VolunteerDashboardModel>((ref) {
  return VolunteerDashboardNotifier()..loadData();
});
