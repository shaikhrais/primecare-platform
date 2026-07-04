import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rn_field_supervisor_dashboard_model.dart';

class RnFieldSupervisorDashboardNotifier extends StateNotifier<RnFieldSupervisorDashboardModel> {
  RnFieldSupervisorDashboardNotifier() : super(const RnFieldSupervisorDashboardModel(isLoading: true));

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

final rn_field_supervisor_dashboardProvider = StateNotifierProvider<RnFieldSupervisorDashboardNotifier, RnFieldSupervisorDashboardModel>((ref) {
  return RnFieldSupervisorDashboardNotifier()..loadData();
});
