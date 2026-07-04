import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_case_study_repository_model.dart';

class PatientCaseStudyRepositoryNotifier extends StateNotifier<PatientCaseStudyRepositoryModel> {
  PatientCaseStudyRepositoryNotifier() : super(const PatientCaseStudyRepositoryModel(isLoading: true));

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

final patient_case_study_repositoryProvider = StateNotifierProvider<PatientCaseStudyRepositoryNotifier, PatientCaseStudyRepositoryModel>((ref) {
  return PatientCaseStudyRepositoryNotifier()..loadData();
});
