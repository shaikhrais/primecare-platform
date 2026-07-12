import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/quality_assurance_analytics_model.dart';

class QualityAssuranceAnalyticsNotifier extends StateNotifier<QualityAssuranceAnalyticsModel> {
  QualityAssuranceAnalyticsNotifier() : super(const QualityAssuranceAnalyticsModel(isLoading: true));

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

final quality_assurance_analyticsProvider = StateNotifierProvider<QualityAssuranceAnalyticsNotifier, QualityAssuranceAnalyticsModel>((ref) {
  return QualityAssuranceAnalyticsNotifier()..loadData();
});
