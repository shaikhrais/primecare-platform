import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinical_director_performance_model.dart';

class ClinicalDirectorPerformanceNotifier extends StateNotifier<ClinicalDirectorPerformanceModel> {
  ClinicalDirectorPerformanceNotifier() : super(const ClinicalDirectorPerformanceModel(isLoading: true));

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

final clinical_director_performanceProvider = StateNotifierProvider<ClinicalDirectorPerformanceNotifier, ClinicalDirectorPerformanceModel>((ref) {
  return ClinicalDirectorPerformanceNotifier()..loadData();
});
