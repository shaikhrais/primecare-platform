import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hipaa_audit_dashboard_model.dart';

class HipaaAuditDashboardNotifier extends StateNotifier<HipaaAuditDashboardModel> {
  HipaaAuditDashboardNotifier() : super(const HipaaAuditDashboardModel(isLoading: true));

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

final hipaa_audit_dashboardProvider = StateNotifierProvider<HipaaAuditDashboardNotifier, HipaaAuditDashboardModel>((ref) {
  return HipaaAuditDashboardNotifier()..loadData();
});
