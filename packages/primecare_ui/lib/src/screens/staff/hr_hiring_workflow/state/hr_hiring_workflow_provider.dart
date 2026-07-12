import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_hiring_workflow_model.dart';

class HrHiringWorkflowNotifier extends StateNotifier<HrHiringWorkflowModel> {
  HrHiringWorkflowNotifier() : super(const HrHiringWorkflowModel(isLoading: true));

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

final hr_hiring_workflowProvider = StateNotifierProvider<HrHiringWorkflowNotifier, HrHiringWorkflowModel>((ref) {
  return HrHiringWorkflowNotifier()..loadData();
});
