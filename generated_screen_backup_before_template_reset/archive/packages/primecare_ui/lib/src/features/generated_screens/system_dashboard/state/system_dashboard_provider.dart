import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/system_dashboard_model.dart';

class SystemDashboardNotifier extends StateNotifier<SystemDashboardModel> {
  SystemDashboardNotifier() : super(const SystemDashboardModel(isLoading: true));

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

final system_dashboardProvider = StateNotifierProvider<SystemDashboardNotifier, SystemDashboardModel>((ref) {
  return SystemDashboardNotifier()..loadData();
});
