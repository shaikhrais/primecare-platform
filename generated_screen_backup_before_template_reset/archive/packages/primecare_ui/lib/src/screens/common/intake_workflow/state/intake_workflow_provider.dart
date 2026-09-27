import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/intake_workflow_model.dart';

class IntakeWorkflowNotifier extends StateNotifier<IntakeWorkflowModel> {
  IntakeWorkflowNotifier() : super(const IntakeWorkflowModel(isLoading: true));

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

final intake_workflowProvider = StateNotifierProvider<IntakeWorkflowNotifier, IntakeWorkflowModel>((ref) {
  return IntakeWorkflowNotifier()..loadData();
});
