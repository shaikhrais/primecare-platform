import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/billing_admin_workflow_model.dart';

class BillingAdminWorkflowNotifier extends StateNotifier<BillingAdminWorkflowModel> {
  BillingAdminWorkflowNotifier() : super(const BillingAdminWorkflowModel(isLoading: true));

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

final billing_admin_workflowProvider = StateNotifierProvider<BillingAdminWorkflowNotifier, BillingAdminWorkflowModel>((ref) {
  return BillingAdminWorkflowNotifier()..loadData();
});
