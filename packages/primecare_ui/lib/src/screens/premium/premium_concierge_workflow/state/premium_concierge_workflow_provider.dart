import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/premium_concierge_workflow_model.dart';

class PremiumConciergeWorkflowNotifier extends StateNotifier<PremiumConciergeWorkflowModel> {
  PremiumConciergeWorkflowNotifier() : super(const PremiumConciergeWorkflowModel(isLoading: true));

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

final premium_concierge_workflowProvider = StateNotifierProvider<PremiumConciergeWorkflowNotifier, PremiumConciergeWorkflowModel>((ref) {
  return PremiumConciergeWorkflowNotifier()..loadData();
});
