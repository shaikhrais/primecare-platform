import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/physician_workflow_model.dart';

class PhysicianWorkflowNotifier extends StateNotifier<PhysicianWorkflowModel> {
  PhysicianWorkflowNotifier() : super(const PhysicianWorkflowModel(isLoading: true));

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

final physician_workflowProvider = StateNotifierProvider<PhysicianWorkflowNotifier, PhysicianWorkflowModel>((ref) {
  return PhysicianWorkflowNotifier()..loadData();
});
