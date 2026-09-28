import 'package:flutter_riverpod/legacy.dart';
import '../models/training_director_trainer_assignments_model.dart';

class TrainingDirectorTrainerAssignmentsNotifier extends StateNotifier<TrainingDirectorTrainerAssignmentsModel> {
  TrainingDirectorTrainerAssignmentsNotifier() : super(const TrainingDirectorTrainerAssignmentsModel(isLoading: true));

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

final training_director_trainer_assignmentsProvider = StateNotifierProvider<TrainingDirectorTrainerAssignmentsNotifier, TrainingDirectorTrainerAssignmentsModel>((ref) {
  return TrainingDirectorTrainerAssignmentsNotifier()..loadData();
});
