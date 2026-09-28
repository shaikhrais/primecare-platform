import 'package:flutter_riverpod/legacy.dart';
import '../models/training_director_training_programs_model.dart';

class TrainingDirectorTrainingProgramsNotifier extends StateNotifier<TrainingDirectorTrainingProgramsModel> {
  TrainingDirectorTrainingProgramsNotifier() : super(const TrainingDirectorTrainingProgramsModel(isLoading: true));

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

final training_director_training_programsProvider = StateNotifierProvider<TrainingDirectorTrainingProgramsNotifier, TrainingDirectorTrainingProgramsModel>((ref) {
  return TrainingDirectorTrainingProgramsNotifier()..loadData();
});
