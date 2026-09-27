import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/it_administrator_dashboard_model.dart';

class ItAdministratorDashboardNotifier extends StateNotifier<ItAdministratorDashboardModel> {
  ItAdministratorDashboardNotifier() : super(const ItAdministratorDashboardModel(isLoading: true));

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

final it_administrator_dashboardProvider = StateNotifierProvider<ItAdministratorDashboardNotifier, ItAdministratorDashboardModel>((ref) {
  return ItAdministratorDashboardNotifier()..loadData();
});
