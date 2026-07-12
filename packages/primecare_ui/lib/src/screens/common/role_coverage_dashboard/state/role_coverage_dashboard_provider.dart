import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/role_coverage_dashboard_model.dart';

class RoleCoverageDashboardNotifier extends StateNotifier<RoleCoverageDashboardModel> {
  RoleCoverageDashboardNotifier() : super(const RoleCoverageDashboardModel(isLoading: true));

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

final role_coverage_dashboardProvider = StateNotifierProvider<RoleCoverageDashboardNotifier, RoleCoverageDashboardModel>((ref) {
  return RoleCoverageDashboardNotifier()..loadData();
});
