import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/receptionist_workflow_model.dart';

class ReceptionistWorkflowNotifier extends StateNotifier<ReceptionistWorkflowModel> {
  ReceptionistWorkflowNotifier() : super(const ReceptionistWorkflowModel(isLoading: true));

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

final receptionist_workflowProvider = StateNotifierProvider<ReceptionistWorkflowNotifier, ReceptionistWorkflowModel>((ref) {
  return ReceptionistWorkflowNotifier()..loadData();
});
