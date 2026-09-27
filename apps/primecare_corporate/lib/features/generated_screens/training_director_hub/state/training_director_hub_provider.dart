import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_director_hub_model.dart';

class TrainingDirectorHubNotifier extends StateNotifier<TrainingDirectorHubModel> {
  TrainingDirectorHubNotifier() : super(const TrainingDirectorHubModel(isLoading: true));

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

final training_director_hubProvider = StateNotifierProvider<TrainingDirectorHubNotifier, TrainingDirectorHubModel>((ref) {
  return TrainingDirectorHubNotifier()..loadData();
});
