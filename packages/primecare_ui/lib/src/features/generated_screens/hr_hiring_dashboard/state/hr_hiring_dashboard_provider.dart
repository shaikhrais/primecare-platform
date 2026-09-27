import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_hiring_dashboard_model.dart';

class HrHiringDashboardNotifier extends StateNotifier<HrHiringDashboardModel> {
  HrHiringDashboardNotifier() : super(const HrHiringDashboardModel(isLoading: true));

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

final hr_hiring_dashboardProvider = StateNotifierProvider<HrHiringDashboardNotifier, HrHiringDashboardModel>((ref) {
  return HrHiringDashboardNotifier()..loadData();
});
