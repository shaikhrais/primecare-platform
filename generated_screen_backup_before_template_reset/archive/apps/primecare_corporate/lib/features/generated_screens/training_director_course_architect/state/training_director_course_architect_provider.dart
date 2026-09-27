import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_director_course_architect_model.dart';

class TrainingDirectorCourseArchitectNotifier extends StateNotifier<TrainingDirectorCourseArchitectModel> {
  TrainingDirectorCourseArchitectNotifier() : super(const TrainingDirectorCourseArchitectModel(isLoading: true));

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

final training_director_course_architectProvider = StateNotifierProvider<TrainingDirectorCourseArchitectNotifier, TrainingDirectorCourseArchitectModel>((ref) {
  return TrainingDirectorCourseArchitectNotifier()..loadData();
});
