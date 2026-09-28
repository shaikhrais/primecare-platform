import 'package:flutter_riverpod/legacy.dart';
import '../models/training_programs_model.dart';

class TrainingProgramsNotifier extends StateNotifier<TrainingProgramsModel> {
  TrainingProgramsNotifier() : super(const TrainingProgramsModel(isLoading: true));

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

final training_programsProvider = StateNotifierProvider<TrainingProgramsNotifier, TrainingProgramsModel>((ref) {
  return TrainingProgramsNotifier()..loadData();
});
