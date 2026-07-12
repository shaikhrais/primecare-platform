import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheduler_conflicts_model.dart';

class SchedulerConflictsNotifier extends StateNotifier<SchedulerConflictsModel> {
  SchedulerConflictsNotifier() : super(const SchedulerConflictsModel(isLoading: true));

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

final scheduler_conflictsProvider = StateNotifierProvider<SchedulerConflictsNotifier, SchedulerConflictsModel>((ref) {
  return SchedulerConflictsNotifier()..loadData();
});
