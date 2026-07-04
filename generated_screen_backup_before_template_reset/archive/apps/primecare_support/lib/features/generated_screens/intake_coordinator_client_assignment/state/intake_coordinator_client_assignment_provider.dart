import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/intake_coordinator_client_assignment_model.dart';

class IntakeCoordinatorClientAssignmentNotifier extends StateNotifier<IntakeCoordinatorClientAssignmentModel> {
  IntakeCoordinatorClientAssignmentNotifier() : super(const IntakeCoordinatorClientAssignmentModel(isLoading: true));

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

final intake_coordinator_client_assignmentProvider = StateNotifierProvider<IntakeCoordinatorClientAssignmentNotifier, IntakeCoordinatorClientAssignmentModel>((ref) {
  return IntakeCoordinatorClientAssignmentNotifier()..loadData();
});
