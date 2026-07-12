import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/c_m_e_tracking_dashboard_model.dart';

class CMETrackingDashboardNotifier extends StateNotifier<CMETrackingDashboardModel> {
  CMETrackingDashboardNotifier() : super(const CMETrackingDashboardModel(isLoading: true));

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

final c_m_e_tracking_dashboardProvider = StateNotifierProvider<CMETrackingDashboardNotifier, CMETrackingDashboardModel>((ref) {
  return CMETrackingDashboardNotifier()..loadData();
});
