import 'package:flutter_riverpod/legacy.dart';
import '../models/territory_sales_manager_pipeline_model.dart';

class TerritorySalesManagerPipelineNotifier extends StateNotifier<TerritorySalesManagerPipelineModel> {
  TerritorySalesManagerPipelineNotifier() : super(const TerritorySalesManagerPipelineModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final territory_sales_manager_pipelineProvider = StateNotifierProvider<TerritorySalesManagerPipelineNotifier, TerritorySalesManagerPipelineModel>((ref) {
  return TerritorySalesManagerPipelineNotifier()..loadData();
});
