import 'package:flutter_riverpod/legacy.dart';
import '../models/quality_metrics_model.dart';

class QualityMetricsNotifier extends StateNotifier<QualityMetricsModel> {
  QualityMetricsNotifier() : super(const QualityMetricsModel(isLoading: true));

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

final quality_metricsProvider = StateNotifierProvider<QualityMetricsNotifier, QualityMetricsModel>((ref) {
  return QualityMetricsNotifier()..loadData();
});
