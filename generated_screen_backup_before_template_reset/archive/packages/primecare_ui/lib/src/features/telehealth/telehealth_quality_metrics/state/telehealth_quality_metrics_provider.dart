import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/telehealth_quality_metrics_model.dart';

class TelehealthQualityMetricsNotifier extends StateNotifier<TelehealthQualityMetricsModel> {
  TelehealthQualityMetricsNotifier() : super(const TelehealthQualityMetricsModel(isLoading: true));

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

final telehealth_quality_metricsProvider = StateNotifierProvider<TelehealthQualityMetricsNotifier, TelehealthQualityMetricsModel>((ref) {
  return TelehealthQualityMetricsNotifier()..loadData();
});
