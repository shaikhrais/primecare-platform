import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compliance_dashboard_model.dart';

class ComplianceDashboardNotifier extends StateNotifier<ComplianceDashboardModel> {
  ComplianceDashboardNotifier() : super(const ComplianceDashboardModel(isLoading: true));

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

final compliance_dashboardProvider = StateNotifierProvider<ComplianceDashboardNotifier, ComplianceDashboardModel>((ref) {
  return ComplianceDashboardNotifier()..loadData();
});
