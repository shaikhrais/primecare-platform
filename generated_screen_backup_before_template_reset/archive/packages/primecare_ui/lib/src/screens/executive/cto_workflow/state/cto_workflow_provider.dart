import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cto_workflow_model.dart';

class CtoWorkflowNotifier extends StateNotifier<CtoWorkflowModel> {
  CtoWorkflowNotifier() : super(const CtoWorkflowModel(isLoading: true));

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

final cto_workflowProvider = StateNotifierProvider<CtoWorkflowNotifier, CtoWorkflowModel>((ref) {
  return CtoWorkflowNotifier()..loadData();
});
