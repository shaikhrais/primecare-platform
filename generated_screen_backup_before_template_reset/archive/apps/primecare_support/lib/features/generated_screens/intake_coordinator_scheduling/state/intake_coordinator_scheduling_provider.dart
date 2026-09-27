import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/intake_coordinator_scheduling_model.dart';

class IntakeCoordinatorSchedulingNotifier extends StateNotifier<IntakeCoordinatorSchedulingModel> {
  IntakeCoordinatorSchedulingNotifier() : super(const IntakeCoordinatorSchedulingModel(isLoading: true));

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

final intake_coordinator_schedulingProvider = StateNotifierProvider<IntakeCoordinatorSchedulingNotifier, IntakeCoordinatorSchedulingModel>((ref) {
  return IntakeCoordinatorSchedulingNotifier()..loadData();
});
