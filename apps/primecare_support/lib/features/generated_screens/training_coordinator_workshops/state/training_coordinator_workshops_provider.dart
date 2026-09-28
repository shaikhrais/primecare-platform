import 'package:flutter_riverpod/legacy.dart';
import '../models/training_coordinator_workshops_model.dart';

class TrainingCoordinatorWorkshopsNotifier extends StateNotifier<TrainingCoordinatorWorkshopsModel> {
  TrainingCoordinatorWorkshopsNotifier() : super(const TrainingCoordinatorWorkshopsModel(isLoading: true));

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

final training_coordinator_workshopsProvider = StateNotifierProvider<TrainingCoordinatorWorkshopsNotifier, TrainingCoordinatorWorkshopsModel>((ref) {
  return TrainingCoordinatorWorkshopsNotifier()..loadData();
});
