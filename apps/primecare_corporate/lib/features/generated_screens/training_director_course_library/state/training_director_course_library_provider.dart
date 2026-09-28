import 'package:flutter_riverpod/legacy.dart';
import '../models/training_director_course_library_model.dart';

class TrainingDirectorCourseLibraryNotifier extends StateNotifier<TrainingDirectorCourseLibraryModel> {
  TrainingDirectorCourseLibraryNotifier() : super(const TrainingDirectorCourseLibraryModel(isLoading: true));

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

final training_director_course_libraryProvider = StateNotifierProvider<TrainingDirectorCourseLibraryNotifier, TrainingDirectorCourseLibraryModel>((ref) {
  return TrainingDirectorCourseLibraryNotifier()..loadData();
});
