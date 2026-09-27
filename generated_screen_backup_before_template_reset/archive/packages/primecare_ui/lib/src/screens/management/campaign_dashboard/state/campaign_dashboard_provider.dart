import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/campaign_dashboard_model.dart';

class CampaignDashboardNotifier extends StateNotifier<CampaignDashboardModel> {
  CampaignDashboardNotifier() : super(const CampaignDashboardModel(isLoading: true));

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

final campaign_dashboardProvider = StateNotifierProvider<CampaignDashboardNotifier, CampaignDashboardModel>((ref) {
  return CampaignDashboardNotifier()..loadData();
});
