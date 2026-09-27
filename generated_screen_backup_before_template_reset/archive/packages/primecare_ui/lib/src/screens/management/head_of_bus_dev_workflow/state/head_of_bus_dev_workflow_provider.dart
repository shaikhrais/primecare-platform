import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/head_of_bus_dev_workflow_model.dart';

class HeadOfBusDevWorkflowNotifier extends StateNotifier<HeadOfBusDevWorkflowModel> {
  HeadOfBusDevWorkflowNotifier() : super(const HeadOfBusDevWorkflowModel(isLoading: true));

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

final head_of_bus_dev_workflowProvider = StateNotifierProvider<HeadOfBusDevWorkflowNotifier, HeadOfBusDevWorkflowModel>((ref) {
  return HeadOfBusDevWorkflowNotifier()..loadData();
});
