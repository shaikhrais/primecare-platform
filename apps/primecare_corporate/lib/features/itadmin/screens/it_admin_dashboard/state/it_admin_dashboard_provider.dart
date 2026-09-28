import 'package:flutter_riverpod/legacy.dart';
import '../models/it_admin_dashboard_model.dart';

class ItAdminDashboardNotifier extends StateNotifier<ItAdminDashboardModel> {
  ItAdminDashboardNotifier() : super(const ItAdminDashboardModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final it_admin_dashboardProvider = StateNotifierProvider<ItAdminDashboardNotifier, ItAdminDashboardModel>((ref) {
  return ItAdminDashboardNotifier()..loadData();
});
