import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compliance_manager_dashboard_model.dart';

class ComplianceManagerDashboardNotifier extends StateNotifier<ComplianceManagerDashboardModel> {
  ComplianceManagerDashboardNotifier() : super(const ComplianceManagerDashboardModel(isLoading: true));

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

final compliance_manager_dashboardProvider = StateNotifierProvider<ComplianceManagerDashboardNotifier, ComplianceManagerDashboardModel>((ref) {
  return ComplianceManagerDashboardNotifier()..loadData();
});
