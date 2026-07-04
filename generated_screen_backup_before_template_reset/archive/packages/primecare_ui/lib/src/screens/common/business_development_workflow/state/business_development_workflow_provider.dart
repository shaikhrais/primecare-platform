import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/business_development_workflow_model.dart';

class BusinessDevelopmentWorkflowNotifier extends StateNotifier<BusinessDevelopmentWorkflowModel> {
  BusinessDevelopmentWorkflowNotifier() : super(const BusinessDevelopmentWorkflowModel(isLoading: true));

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

final business_development_workflowProvider = StateNotifierProvider<BusinessDevelopmentWorkflowNotifier, BusinessDevelopmentWorkflowModel>((ref) {
  return BusinessDevelopmentWorkflowNotifier()..loadData();
});
