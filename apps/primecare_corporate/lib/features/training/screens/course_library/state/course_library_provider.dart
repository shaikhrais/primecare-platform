import 'package:flutter_riverpod/legacy.dart';
import '../models/course_library_model.dart';

class CourseLibraryNotifier extends StateNotifier<CourseLibraryModel> {
  CourseLibraryNotifier() : super(const CourseLibraryModel(isLoading: true));

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

final course_libraryProvider = StateNotifierProvider<CourseLibraryNotifier, CourseLibraryModel>((ref) {
  return CourseLibraryNotifier()..loadData();
});
