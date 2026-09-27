import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_director_dashboard_model.dart';

class HrDirectorDashboardNotifier extends StateNotifier<HrDirectorDashboardModel> {
  HrDirectorDashboardNotifier() : super(const HrDirectorDashboardModel(isLoading: true));

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

final hr_director_dashboardProvider = StateNotifierProvider<HrDirectorDashboardNotifier, HrDirectorDashboardModel>((ref) {
  return HrDirectorDashboardNotifier()..loadData();
});
