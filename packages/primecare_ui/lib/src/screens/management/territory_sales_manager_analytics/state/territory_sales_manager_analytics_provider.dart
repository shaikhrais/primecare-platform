import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/territory_sales_manager_analytics_model.dart';

class TerritorySalesManagerAnalyticsNotifier extends StateNotifier<TerritorySalesManagerAnalyticsModel> {
  TerritorySalesManagerAnalyticsNotifier() : super(const TerritorySalesManagerAnalyticsModel(isLoading: true));

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

final territory_sales_manager_analyticsProvider = StateNotifierProvider<TerritorySalesManagerAnalyticsNotifier, TerritorySalesManagerAnalyticsModel>((ref) {
  return TerritorySalesManagerAnalyticsNotifier()..loadData();
});
