import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/infection_control_dashboard_model.dart';

class InfectionControlDashboardNotifier extends StateNotifier<InfectionControlDashboardModel> {
  InfectionControlDashboardNotifier() : super(const InfectionControlDashboardModel(isLoading: true));

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

final infection_control_dashboardProvider = StateNotifierProvider<InfectionControlDashboardNotifier, InfectionControlDashboardModel>((ref) {
  return InfectionControlDashboardNotifier()..loadData();
});
