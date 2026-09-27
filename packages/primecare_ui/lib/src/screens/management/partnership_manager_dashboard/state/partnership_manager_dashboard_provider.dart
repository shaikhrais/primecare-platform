import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/partnership_manager_dashboard_model.dart';

class PartnershipManagerDashboardNotifier extends StateNotifier<PartnershipManagerDashboardModel> {
  PartnershipManagerDashboardNotifier() : super(const PartnershipManagerDashboardModel(isLoading: true));

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

final partnership_manager_dashboardProvider = StateNotifierProvider<PartnershipManagerDashboardNotifier, PartnershipManagerDashboardModel>((ref) {
  return PartnershipManagerDashboardNotifier()..loadData();
});
