import 'package:flutter_riverpod/legacy.dart';
import '../models/training_director_staff_training_matrix_model.dart';

class TrainingDirectorStaffTrainingMatrixNotifier extends StateNotifier<TrainingDirectorStaffTrainingMatrixModel> {
  TrainingDirectorStaffTrainingMatrixNotifier() : super(const TrainingDirectorStaffTrainingMatrixModel(isLoading: true));

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

final training_director_staff_training_matrixProvider = StateNotifierProvider<TrainingDirectorStaffTrainingMatrixNotifier, TrainingDirectorStaffTrainingMatrixModel>((ref) {
  return TrainingDirectorStaffTrainingMatrixNotifier()..loadData();
});
