import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_coordinator_analytics_model.dart';

class TrainingCoordinatorAnalyticsNotifier extends StateNotifier<TrainingCoordinatorAnalyticsModel> {
  TrainingCoordinatorAnalyticsNotifier() : super(const TrainingCoordinatorAnalyticsModel(isLoading: true));

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

final training_coordinator_analyticsProvider = StateNotifierProvider<TrainingCoordinatorAnalyticsNotifier, TrainingCoordinatorAnalyticsModel>((ref) {
  return TrainingCoordinatorAnalyticsNotifier()..loadData();
});
