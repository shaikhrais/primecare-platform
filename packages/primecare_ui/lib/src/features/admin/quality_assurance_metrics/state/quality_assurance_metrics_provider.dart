import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/quality_assurance_metrics_model.dart';

class QualityAssuranceMetricsNotifier extends StateNotifier<QualityAssuranceMetricsModel> {
  QualityAssuranceMetricsNotifier() : super(const QualityAssuranceMetricsModel(isLoading: true));

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

final quality_assurance_metricsProvider = StateNotifierProvider<QualityAssuranceMetricsNotifier, QualityAssuranceMetricsModel>((ref) {
  return QualityAssuranceMetricsNotifier()..loadData();
});
