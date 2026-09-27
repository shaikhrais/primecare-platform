import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinic_analytics_model.dart';

class ClinicAnalyticsNotifier extends StateNotifier<ClinicAnalyticsModel> {
  ClinicAnalyticsNotifier() : super(const ClinicAnalyticsModel(isLoading: true));

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

final clinic_analyticsProvider = StateNotifierProvider<ClinicAnalyticsNotifier, ClinicAnalyticsModel>((ref) {
  return ClinicAnalyticsNotifier()..loadData();
});
