import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/territory_sales_manager_area_performance_model.dart';

class TerritorySalesManagerAreaPerformanceNotifier extends StateNotifier<TerritorySalesManagerAreaPerformanceModel> {
  TerritorySalesManagerAreaPerformanceNotifier() : super(const TerritorySalesManagerAreaPerformanceModel(isLoading: true));

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

final territory_sales_manager_area_performanceProvider = StateNotifierProvider<TerritorySalesManagerAreaPerformanceNotifier, TerritorySalesManagerAreaPerformanceModel>((ref) {
  return TerritorySalesManagerAreaPerformanceNotifier()..loadData();
});
