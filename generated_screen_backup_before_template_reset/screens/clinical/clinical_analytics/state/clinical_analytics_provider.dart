import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinical_analytics_model.dart';

class ClinicalAnalyticsNotifier extends StateNotifier<ClinicalAnalyticsModel> {
  ClinicalAnalyticsNotifier() : super(const ClinicalAnalyticsModel(isLoading: true));

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

final clinical_analyticsProvider = StateNotifierProvider<ClinicalAnalyticsNotifier, ClinicalAnalyticsModel>((ref) {
  return ClinicalAnalyticsNotifier()..loadData();
});
