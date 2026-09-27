import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/territory_sales_manager_reports_model.dart';

class TerritorySalesManagerReportsNotifier extends StateNotifier<TerritorySalesManagerReportsModel> {
  TerritorySalesManagerReportsNotifier() : super(const TerritorySalesManagerReportsModel(isLoading: true));

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

final territory_sales_manager_reportsProvider = StateNotifierProvider<TerritorySalesManagerReportsNotifier, TerritorySalesManagerReportsModel>((ref) {
  return TerritorySalesManagerReportsNotifier()..loadData();
});
