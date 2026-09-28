import 'package:flutter_riverpod/legacy.dart';
import '../models/admin_dashboard_model.dart';

class AdminDashboardNotifier extends StateNotifier<AdminDashboardModel> {
  AdminDashboardNotifier() : super(const AdminDashboardModel(isLoading: true));

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

final admin_dashboardProvider = StateNotifierProvider<AdminDashboardNotifier, AdminDashboardModel>((ref) {
  return AdminDashboardNotifier()..loadData();
});
