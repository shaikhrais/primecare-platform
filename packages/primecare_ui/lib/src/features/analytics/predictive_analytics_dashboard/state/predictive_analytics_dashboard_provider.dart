import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/predictive_analytics_dashboard_model.dart';

class PredictiveAnalyticsDashboardNotifier extends StateNotifier<PredictiveAnalyticsDashboardModel> {
  PredictiveAnalyticsDashboardNotifier() : super(const PredictiveAnalyticsDashboardModel(isLoading: true));

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

final predictive_analytics_dashboardProvider = StateNotifierProvider<PredictiveAnalyticsDashboardNotifier, PredictiveAnalyticsDashboardModel>((ref) {
  return PredictiveAnalyticsDashboardNotifier()..loadData();
});
