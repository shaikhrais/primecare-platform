import 'package:flutter_riverpod/legacy.dart';
import '../models/training_coordinator_training_schedule_model.dart';

class TrainingCoordinatorTrainingScheduleNotifier extends StateNotifier<TrainingCoordinatorTrainingScheduleModel> {
  TrainingCoordinatorTrainingScheduleNotifier() : super(const TrainingCoordinatorTrainingScheduleModel(isLoading: true));

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

final training_coordinator_training_scheduleProvider = StateNotifierProvider<TrainingCoordinatorTrainingScheduleNotifier, TrainingCoordinatorTrainingScheduleModel>((ref) {
  return TrainingCoordinatorTrainingScheduleNotifier()..loadData();
});
