import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/customer_support_workflow_model.dart';

class CustomerSupportWorkflowNotifier extends StateNotifier<CustomerSupportWorkflowModel> {
  CustomerSupportWorkflowNotifier() : super(const CustomerSupportWorkflowModel(isLoading: true));

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

final customer_support_workflowProvider = StateNotifierProvider<CustomerSupportWorkflowNotifier, CustomerSupportWorkflowModel>((ref) {
  return CustomerSupportWorkflowNotifier()..loadData();
});
