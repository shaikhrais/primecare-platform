import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scrum_master_dashboard_model.dart';

class ScrumMasterDashboardNotifier extends StateNotifier<ScrumMasterDashboardModel> {
  ScrumMasterDashboardNotifier() : super(const ScrumMasterDashboardModel(isLoading: true));

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

final scrum_master_dashboardProvider = StateNotifierProvider<ScrumMasterDashboardNotifier, ScrumMasterDashboardModel>((ref) {
  return ScrumMasterDashboardNotifier()..loadData();
});
