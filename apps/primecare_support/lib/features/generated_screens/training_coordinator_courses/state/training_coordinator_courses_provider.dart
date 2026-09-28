import 'package:flutter_riverpod/legacy.dart';
import '../models/training_coordinator_courses_model.dart';

class TrainingCoordinatorCoursesNotifier extends StateNotifier<TrainingCoordinatorCoursesModel> {
  TrainingCoordinatorCoursesNotifier() : super(const TrainingCoordinatorCoursesModel(isLoading: true));

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

final training_coordinator_coursesProvider = StateNotifierProvider<TrainingCoordinatorCoursesNotifier, TrainingCoordinatorCoursesModel>((ref) {
  return TrainingCoordinatorCoursesNotifier()..loadData();
});
