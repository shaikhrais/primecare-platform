import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheduler_coordinator_assignments_model.dart';

class SchedulerCoordinatorAssignmentsNotifier extends StateNotifier<SchedulerCoordinatorAssignmentsModel> {
  SchedulerCoordinatorAssignmentsNotifier() : super(const SchedulerCoordinatorAssignmentsModel(isLoading: true));

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

final scheduler_coordinator_assignmentsProvider = StateNotifierProvider<SchedulerCoordinatorAssignmentsNotifier, SchedulerCoordinatorAssignmentsModel>((ref) {
  return SchedulerCoordinatorAssignmentsNotifier()..loadData();
});
