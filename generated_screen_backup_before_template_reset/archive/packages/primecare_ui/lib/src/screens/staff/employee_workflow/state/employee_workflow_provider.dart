import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/employee_workflow_model.dart';

class EmployeeWorkflowNotifier extends StateNotifier<EmployeeWorkflowModel> {
  EmployeeWorkflowNotifier() : super(const EmployeeWorkflowModel(isLoading: true));

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

final employee_workflowProvider = StateNotifierProvider<EmployeeWorkflowNotifier, EmployeeWorkflowModel>((ref) {
  return EmployeeWorkflowNotifier()..loadData();
});
