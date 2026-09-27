import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_coordinator_progress_model.dart';

class TrainingCoordinatorProgressNotifier extends StateNotifier<TrainingCoordinatorProgressModel> {
  TrainingCoordinatorProgressNotifier() : super(const TrainingCoordinatorProgressModel(isLoading: true));

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

final training_coordinator_progressProvider = StateNotifierProvider<TrainingCoordinatorProgressNotifier, TrainingCoordinatorProgressModel>((ref) {
  return TrainingCoordinatorProgressNotifier()..loadData();
});
