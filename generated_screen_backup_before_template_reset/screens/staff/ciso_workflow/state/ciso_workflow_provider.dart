import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ciso_workflow_model.dart';

class CisoWorkflowNotifier extends StateNotifier<CisoWorkflowModel> {
  CisoWorkflowNotifier() : super(const CisoWorkflowModel(isLoading: true));

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

final ciso_workflowProvider = StateNotifierProvider<CisoWorkflowNotifier, CisoWorkflowModel>((ref) {
  return CisoWorkflowNotifier()..loadData();
});
