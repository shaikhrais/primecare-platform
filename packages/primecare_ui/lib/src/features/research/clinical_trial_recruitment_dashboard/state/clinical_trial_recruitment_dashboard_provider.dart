import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinical_trial_recruitment_dashboard_model.dart';

class ClinicalTrialRecruitmentDashboardNotifier extends StateNotifier<ClinicalTrialRecruitmentDashboardModel> {
  ClinicalTrialRecruitmentDashboardNotifier() : super(const ClinicalTrialRecruitmentDashboardModel(isLoading: true));

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

final clinical_trial_recruitment_dashboardProvider = StateNotifierProvider<ClinicalTrialRecruitmentDashboardNotifier, ClinicalTrialRecruitmentDashboardModel>((ref) {
  return ClinicalTrialRecruitmentDashboardNotifier()..loadData();
});
