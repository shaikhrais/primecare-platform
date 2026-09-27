import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_hub_model.dart';

class TrainingHubNotifier extends StateNotifier<TrainingHubModel> {
  TrainingHubNotifier() : super(const TrainingHubModel(isLoading: true));

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

final training_hubProvider = StateNotifierProvider<TrainingHubNotifier, TrainingHubModel>((ref) {
  return TrainingHubNotifier()..loadData();
});
