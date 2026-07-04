import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cx_director_workflow_model.dart';

class CxDirectorWorkflowNotifier extends StateNotifier<CxDirectorWorkflowModel> {
  CxDirectorWorkflowNotifier() : super(const CxDirectorWorkflowModel(isLoading: true));

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

final cx_director_workflowProvider = StateNotifierProvider<CxDirectorWorkflowNotifier, CxDirectorWorkflowModel>((ref) {
  return CxDirectorWorkflowNotifier()..loadData();
});
