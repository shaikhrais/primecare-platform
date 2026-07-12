import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/remote_patient_monitoring_dashboard_model.dart';

class RemotePatientMonitoringDashboardNotifier extends StateNotifier<RemotePatientMonitoringDashboardModel> {
  RemotePatientMonitoringDashboardNotifier() : super(const RemotePatientMonitoringDashboardModel(isLoading: true));

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

final remote_patient_monitoring_dashboardProvider = StateNotifierProvider<RemotePatientMonitoringDashboardNotifier, RemotePatientMonitoringDashboardModel>((ref) {
  return RemotePatientMonitoringDashboardNotifier()..loadData();
});
