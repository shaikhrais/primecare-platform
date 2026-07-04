import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_analytics_model.dart';

class PatientAnalyticsNotifier extends StateNotifier<PatientAnalyticsModel> {
  PatientAnalyticsNotifier() : super(const PatientAnalyticsModel(isLoading: true));

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

final patient_analyticsProvider = StateNotifierProvider<PatientAnalyticsNotifier, PatientAnalyticsModel>((ref) {
  return PatientAnalyticsNotifier()..loadData();
});
