import 'package:flutter_riverpod/legacy.dart';
import '../models/audit_dashboard_model.dart';

class AuditDashboardNotifier extends StateNotifier<AuditDashboardModel> {
  AuditDashboardNotifier() : super(const AuditDashboardModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final audit_dashboardProvider = StateNotifierProvider<AuditDashboardNotifier, AuditDashboardModel>((ref) {
  return AuditDashboardNotifier()..loadData();
});
