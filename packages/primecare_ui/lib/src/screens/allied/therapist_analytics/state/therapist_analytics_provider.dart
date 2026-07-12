import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/therapist_analytics_model.dart';

class TherapistAnalyticsNotifier extends StateNotifier<TherapistAnalyticsModel> {
  TherapistAnalyticsNotifier() : super(const TherapistAnalyticsModel(isLoading: true));

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

final therapist_analyticsProvider = StateNotifierProvider<TherapistAnalyticsNotifier, TherapistAnalyticsModel>((ref) {
  return TherapistAnalyticsNotifier()..loadData();
});
