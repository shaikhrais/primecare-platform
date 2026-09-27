import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/provider_performance_dashboard_model.dart';

class ProviderPerformanceDashboardNotifier extends StateNotifier<ProviderPerformanceDashboardModel> {
  ProviderPerformanceDashboardNotifier() : super(const ProviderPerformanceDashboardModel(isLoading: true));

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

final provider_performance_dashboardProvider = StateNotifierProvider<ProviderPerformanceDashboardNotifier, ProviderPerformanceDashboardModel>((ref) {
  return ProviderPerformanceDashboardNotifier()..loadData();
});
