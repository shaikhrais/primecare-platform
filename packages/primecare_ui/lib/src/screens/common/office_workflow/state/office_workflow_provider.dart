import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/office_workflow_model.dart';

class OfficeWorkflowNotifier extends StateNotifier<OfficeWorkflowModel> {
  OfficeWorkflowNotifier() : super(const OfficeWorkflowModel(isLoading: true));

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

final office_workflowProvider = StateNotifierProvider<OfficeWorkflowNotifier, OfficeWorkflowModel>((ref) {
  return OfficeWorkflowNotifier()..loadData();
});
