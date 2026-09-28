import 'package:flutter_riverpod/legacy.dart';
import '../models/training_director_assessments_model.dart';

class TrainingDirectorAssessmentsNotifier extends StateNotifier<TrainingDirectorAssessmentsModel> {
  TrainingDirectorAssessmentsNotifier() : super(const TrainingDirectorAssessmentsModel(isLoading: true));

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

final training_director_assessmentsProvider = StateNotifierProvider<TrainingDirectorAssessmentsNotifier, TrainingDirectorAssessmentsModel>((ref) {
  return TrainingDirectorAssessmentsNotifier()..loadData();
});
