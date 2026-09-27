import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cx_director_dashboard_model.dart';

class CxDirectorDashboardNotifier extends StateNotifier<CxDirectorDashboardModel> {
  CxDirectorDashboardNotifier() : super(const CxDirectorDashboardModel(isLoading: true));

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

final cx_director_dashboardProvider = StateNotifierProvider<CxDirectorDashboardNotifier, CxDirectorDashboardModel>((ref) {
  return CxDirectorDashboardNotifier()..loadData();
});
