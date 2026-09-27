import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/social_worker_workflow_model.dart';

class SocialWorkerWorkflowNotifier extends StateNotifier<SocialWorkerWorkflowModel> {
  SocialWorkerWorkflowNotifier() : super(const SocialWorkerWorkflowModel(isLoading: true));

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

final social_worker_workflowProvider = StateNotifierProvider<SocialWorkerWorkflowNotifier, SocialWorkerWorkflowModel>((ref) {
  return SocialWorkerWorkflowNotifier()..loadData();
});
