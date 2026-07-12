import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinical_dashboard_model.dart';

class ClinicalDashboardNotifier extends StateNotifier<ClinicalDashboardModel> {
  ClinicalDashboardNotifier() : super(const ClinicalDashboardModel(isLoading: true));

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

final clinical_dashboardProvider = StateNotifierProvider<ClinicalDashboardNotifier, ClinicalDashboardModel>((ref) {
  return ClinicalDashboardNotifier()..loadData();
});
