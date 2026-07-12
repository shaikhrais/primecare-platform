import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/territory_sales_manager_dashboard_model.dart';

class TerritorySalesManagerDashboardNotifier extends StateNotifier<TerritorySalesManagerDashboardModel> {
  TerritorySalesManagerDashboardNotifier() : super(const TerritorySalesManagerDashboardModel(isLoading: true));

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

final territory_sales_manager_dashboardProvider = StateNotifierProvider<TerritorySalesManagerDashboardNotifier, TerritorySalesManagerDashboardModel>((ref) {
  return TerritorySalesManagerDashboardNotifier()..loadData();
});
