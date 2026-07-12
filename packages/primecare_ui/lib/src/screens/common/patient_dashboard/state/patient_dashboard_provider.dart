import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_dashboard_model.dart';

class PatientDashboardNotifier extends StateNotifier<PatientDashboardModel> {
  PatientDashboardNotifier() : super(const PatientDashboardModel(isLoading: true));

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

final patient_dashboardProvider = StateNotifierProvider<PatientDashboardNotifier, PatientDashboardModel>((ref) {
  return PatientDashboardNotifier()..loadData();
});
