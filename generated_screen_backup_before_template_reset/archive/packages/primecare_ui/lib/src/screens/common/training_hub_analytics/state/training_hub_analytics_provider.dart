import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_hub_analytics_model.dart';

class TrainingHubAnalyticsNotifier extends StateNotifier<TrainingHubAnalyticsModel> {
  TrainingHubAnalyticsNotifier() : super(const TrainingHubAnalyticsModel(isLoading: true));

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

final training_hub_analyticsProvider = StateNotifierProvider<TrainingHubAnalyticsNotifier, TrainingHubAnalyticsModel>((ref) {
  return TrainingHubAnalyticsNotifier()..loadData();
});
