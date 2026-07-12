import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_director_analytics_model.dart';

class TrainingDirectorAnalyticsNotifier extends StateNotifier<TrainingDirectorAnalyticsModel> {
  TrainingDirectorAnalyticsNotifier() : super(const TrainingDirectorAnalyticsModel(isLoading: true));

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

final training_director_analyticsProvider = StateNotifierProvider<TrainingDirectorAnalyticsNotifier, TrainingDirectorAnalyticsModel>((ref) {
  return TrainingDirectorAnalyticsNotifier()..loadData();
});
