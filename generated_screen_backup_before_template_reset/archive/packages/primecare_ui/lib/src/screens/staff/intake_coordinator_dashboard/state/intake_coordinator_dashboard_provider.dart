import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/intake_coordinator_dashboard_model.dart';

class IntakeCoordinatorDashboardNotifier extends StateNotifier<IntakeCoordinatorDashboardModel> {
  IntakeCoordinatorDashboardNotifier() : super(const IntakeCoordinatorDashboardModel(isLoading: true));

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

final intake_coordinator_dashboardProvider = StateNotifierProvider<IntakeCoordinatorDashboardNotifier, IntakeCoordinatorDashboardModel>((ref) {
  return IntakeCoordinatorDashboardNotifier()..loadData();
});
