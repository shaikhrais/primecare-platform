import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_workflow_model.dart';

class PswWorkflowNotifier extends StateNotifier<PswWorkflowModel> {
  PswWorkflowNotifier() : super(const PswWorkflowModel(isLoading: true));

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

final psw_workflowProvider = StateNotifierProvider<PswWorkflowNotifier, PswWorkflowModel>((ref) {
  return PswWorkflowNotifier()..loadData();
});
