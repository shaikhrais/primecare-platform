import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vip_manager_dashboard_model.dart';

class VipManagerDashboardNotifier extends StateNotifier<VipManagerDashboardModel> {
  VipManagerDashboardNotifier() : super(const VipManagerDashboardModel(isLoading: true));

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

final vip_manager_dashboardProvider = StateNotifierProvider<VipManagerDashboardNotifier, VipManagerDashboardModel>((ref) {
  return VipManagerDashboardNotifier()..loadData();
});
