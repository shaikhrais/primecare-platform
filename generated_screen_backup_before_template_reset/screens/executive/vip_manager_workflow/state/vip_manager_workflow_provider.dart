import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vip_manager_workflow_model.dart';

class VipManagerWorkflowNotifier extends StateNotifier<VipManagerWorkflowModel> {
  VipManagerWorkflowNotifier() : super(const VipManagerWorkflowModel(isLoading: true));

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

final vip_manager_workflowProvider = StateNotifierProvider<VipManagerWorkflowNotifier, VipManagerWorkflowModel>((ref) {
  return VipManagerWorkflowNotifier()..loadData();
});
