import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rmt_workflow_model.dart';

class RmtWorkflowNotifier extends StateNotifier<RmtWorkflowModel> {
  RmtWorkflowNotifier() : super(const RmtWorkflowModel(isLoading: true));

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

final rmt_workflowProvider = StateNotifierProvider<RmtWorkflowNotifier, RmtWorkflowModel>((ref) {
  return RmtWorkflowNotifier()..loadData();
});
