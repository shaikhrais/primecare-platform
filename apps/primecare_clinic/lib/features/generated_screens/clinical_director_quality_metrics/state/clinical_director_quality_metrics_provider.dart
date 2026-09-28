import 'package:flutter_riverpod/legacy.dart';
import '../models/clinical_director_quality_metrics_model.dart';

class ClinicalDirectorQualityMetricsNotifier extends StateNotifier<ClinicalDirectorQualityMetricsModel> {
  ClinicalDirectorQualityMetricsNotifier() : super(const ClinicalDirectorQualityMetricsModel(isLoading: true));

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

final clinical_director_quality_metricsProvider = StateNotifierProvider<ClinicalDirectorQualityMetricsNotifier, ClinicalDirectorQualityMetricsModel>((ref) {
  return ClinicalDirectorQualityMetricsNotifier()..loadData();
});
