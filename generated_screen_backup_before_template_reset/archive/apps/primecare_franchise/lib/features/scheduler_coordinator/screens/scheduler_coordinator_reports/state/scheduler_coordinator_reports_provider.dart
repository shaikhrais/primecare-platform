import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheduler_coordinator_reports_model.dart';

class SchedulerCoordinatorReportsNotifier extends StateNotifier<SchedulerCoordinatorReportsModel> {
  SchedulerCoordinatorReportsNotifier() : super(const SchedulerCoordinatorReportsModel(isLoading: true));

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

final scheduler_coordinator_reportsProvider = StateNotifierProvider<SchedulerCoordinatorReportsNotifier, SchedulerCoordinatorReportsModel>((ref) {
  return SchedulerCoordinatorReportsNotifier()..loadData();
});
