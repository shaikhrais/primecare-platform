import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_retention_analytics_model.dart';

class PatientRetentionAnalyticsNotifier extends StateNotifier<PatientRetentionAnalyticsModel> {
  PatientRetentionAnalyticsNotifier() : super(const PatientRetentionAnalyticsModel(isLoading: true));

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

final patient_retention_analyticsProvider = StateNotifierProvider<PatientRetentionAnalyticsNotifier, PatientRetentionAnalyticsModel>((ref) {
  return PatientRetentionAnalyticsNotifier()..loadData();
});
