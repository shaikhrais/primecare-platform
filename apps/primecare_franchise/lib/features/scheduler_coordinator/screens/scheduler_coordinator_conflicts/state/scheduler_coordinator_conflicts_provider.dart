import 'package:flutter_riverpod/legacy.dart';
import '../models/scheduler_coordinator_conflicts_model.dart';

class SchedulerCoordinatorConflictsNotifier extends StateNotifier<SchedulerCoordinatorConflictsModel> {
  SchedulerCoordinatorConflictsNotifier() : super(const SchedulerCoordinatorConflictsModel(isLoading: true));

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

final scheduler_coordinator_conflictsProvider = StateNotifierProvider<SchedulerCoordinatorConflictsNotifier, SchedulerCoordinatorConflictsModel>((ref) {
  return SchedulerCoordinatorConflictsNotifier()..loadData();
});
