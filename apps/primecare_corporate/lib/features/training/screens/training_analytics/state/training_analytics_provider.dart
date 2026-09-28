import 'package:flutter_riverpod/legacy.dart';
import '../models/training_analytics_model.dart';

class TrainingAnalyticsNotifier extends StateNotifier<TrainingAnalyticsModel> {
  TrainingAnalyticsNotifier() : super(const TrainingAnalyticsModel(isLoading: true));

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

final training_analyticsProvider = StateNotifierProvider<TrainingAnalyticsNotifier, TrainingAnalyticsModel>((ref) {
  return TrainingAnalyticsNotifier()..loadData();
});
