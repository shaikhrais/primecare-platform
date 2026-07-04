import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinical_director_reports_model.dart';

class ClinicalDirectorReportsNotifier extends StateNotifier<ClinicalDirectorReportsModel> {
  ClinicalDirectorReportsNotifier() : super(const ClinicalDirectorReportsModel(isLoading: true));

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

final clinical_director_reportsProvider = StateNotifierProvider<ClinicalDirectorReportsNotifier, ClinicalDirectorReportsModel>((ref) {
  return ClinicalDirectorReportsNotifier()..loadData();
});
