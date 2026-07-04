import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/regional_bdm_workflow_model.dart';

class RegionalBdmWorkflowNotifier extends StateNotifier<RegionalBdmWorkflowModel> {
  RegionalBdmWorkflowNotifier() : super(const RegionalBdmWorkflowModel(isLoading: true));

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

final regional_bdm_workflowProvider = StateNotifierProvider<RegionalBdmWorkflowNotifier, RegionalBdmWorkflowModel>((ref) {
  return RegionalBdmWorkflowNotifier()..loadData();
});
