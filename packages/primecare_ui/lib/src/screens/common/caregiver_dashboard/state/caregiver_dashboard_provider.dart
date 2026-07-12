import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/caregiver_dashboard_model.dart';

class CaregiverDashboardNotifier extends StateNotifier<CaregiverDashboardModel> {
  CaregiverDashboardNotifier() : super(const CaregiverDashboardModel(isLoading: true));

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

final caregiver_dashboardProvider = StateNotifierProvider<CaregiverDashboardNotifier, CaregiverDashboardModel>((ref) {
  return CaregiverDashboardNotifier()..loadData();
});
