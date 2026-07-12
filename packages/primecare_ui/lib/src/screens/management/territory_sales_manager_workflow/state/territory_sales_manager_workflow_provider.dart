import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/territory_sales_manager_workflow_model.dart';

class TerritorySalesManagerWorkflowNotifier extends StateNotifier<TerritorySalesManagerWorkflowModel> {
  TerritorySalesManagerWorkflowNotifier() : super(const TerritorySalesManagerWorkflowModel(isLoading: true));

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

final territory_sales_manager_workflowProvider = StateNotifierProvider<TerritorySalesManagerWorkflowNotifier, TerritorySalesManagerWorkflowModel>((ref) {
  return TerritorySalesManagerWorkflowNotifier()..loadData();
});
