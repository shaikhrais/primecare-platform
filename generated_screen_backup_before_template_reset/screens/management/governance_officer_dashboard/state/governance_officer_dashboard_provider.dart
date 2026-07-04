import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/governance_officer_dashboard_model.dart';

class GovernanceOfficerDashboardNotifier extends StateNotifier<GovernanceOfficerDashboardModel> {
  GovernanceOfficerDashboardNotifier() : super(const GovernanceOfficerDashboardModel(isLoading: true));

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

final governance_officer_dashboardProvider = StateNotifierProvider<GovernanceOfficerDashboardNotifier, GovernanceOfficerDashboardModel>((ref) {
  return GovernanceOfficerDashboardNotifier()..loadData();
});
