import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/territory_expansion_manager_workflow_model.dart';

class TerritoryExpansionManagerWorkflowNotifier extends StateNotifier<TerritoryExpansionManagerWorkflowModel> {
  TerritoryExpansionManagerWorkflowNotifier() : super(const TerritoryExpansionManagerWorkflowModel(isLoading: true));

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

final territory_expansion_manager_workflowProvider = StateNotifierProvider<TerritoryExpansionManagerWorkflowNotifier, TerritoryExpansionManagerWorkflowModel>((ref) {
  return TerritoryExpansionManagerWorkflowNotifier()..loadData();
});
