import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinic_dashboard_model.dart';

class ClinicDashboardNotifier extends StateNotifier<ClinicDashboardModel> {
  ClinicDashboardNotifier() : super(const ClinicDashboardModel(isLoading: true));

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

final clinic_dashboardProvider = StateNotifierProvider<ClinicDashboardNotifier, ClinicDashboardModel>((ref) {
  return ClinicDashboardNotifier()..loadData();
});
