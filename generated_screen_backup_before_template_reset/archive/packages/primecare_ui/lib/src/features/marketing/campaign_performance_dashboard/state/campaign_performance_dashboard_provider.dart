import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/campaign_performance_dashboard_model.dart';

class CampaignPerformanceDashboardNotifier extends StateNotifier<CampaignPerformanceDashboardModel> {
  CampaignPerformanceDashboardNotifier() : super(const CampaignPerformanceDashboardModel(isLoading: true));

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

final campaign_performance_dashboardProvider = StateNotifierProvider<CampaignPerformanceDashboardNotifier, CampaignPerformanceDashboardModel>((ref) {
  return CampaignPerformanceDashboardNotifier()..loadData();
});
