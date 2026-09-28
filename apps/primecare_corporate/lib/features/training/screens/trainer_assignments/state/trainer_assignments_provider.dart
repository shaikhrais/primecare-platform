import 'package:flutter_riverpod/legacy.dart';
import '../models/trainer_assignments_model.dart';

class TrainerAssignmentsNotifier extends StateNotifier<TrainerAssignmentsModel> {
  TrainerAssignmentsNotifier() : super(const TrainerAssignmentsModel(isLoading: true));

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

final trainer_assignmentsProvider = StateNotifierProvider<TrainerAssignmentsNotifier, TrainerAssignmentsModel>((ref) {
  return TrainerAssignmentsNotifier()..loadData();
});
