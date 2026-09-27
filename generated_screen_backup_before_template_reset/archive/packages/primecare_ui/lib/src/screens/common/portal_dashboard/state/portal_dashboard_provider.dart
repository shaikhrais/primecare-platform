import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/portal_dashboard_model.dart';

class PortalDashboardNotifier extends StateNotifier<PortalDashboardModel> {
  PortalDashboardNotifier() : super(const PortalDashboardModel(isLoading: true));

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

final portal_dashboardProvider = StateNotifierProvider<PortalDashboardNotifier, PortalDashboardModel>((ref) {
  return PortalDashboardNotifier()..loadData();
});
