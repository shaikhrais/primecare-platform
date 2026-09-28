import 'package:flutter_riverpod/legacy.dart';
import '../models/regional_manager_dashboard_model.dart';

class RegionalManagerDashboardNotifier extends StateNotifier<RegionalManagerDashboardModel> {
  RegionalManagerDashboardNotifier() : super(const RegionalManagerDashboardModel(isLoading: true));

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

final regional_manager_dashboardProvider = StateNotifierProvider<RegionalManagerDashboardNotifier, RegionalManagerDashboardModel>((ref) {
  return RegionalManagerDashboardNotifier()..loadData();
});
