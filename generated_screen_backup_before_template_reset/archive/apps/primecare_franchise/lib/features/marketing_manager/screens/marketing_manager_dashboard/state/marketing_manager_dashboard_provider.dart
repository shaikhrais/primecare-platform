import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/marketing_manager_dashboard_model.dart';

class MarketingManagerDashboardNotifier extends StateNotifier<MarketingManagerDashboardModel> {
  MarketingManagerDashboardNotifier() : super(const MarketingManagerDashboardModel(isLoading: true));

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

final marketing_manager_dashboardProvider = StateNotifierProvider<MarketingManagerDashboardNotifier, MarketingManagerDashboardModel>((ref) {
  return MarketingManagerDashboardNotifier()..loadData();
});
