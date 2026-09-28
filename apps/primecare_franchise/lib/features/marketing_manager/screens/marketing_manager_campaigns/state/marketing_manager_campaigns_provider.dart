import 'package:flutter_riverpod/legacy.dart';
import '../models/marketing_manager_campaigns_model.dart';

class MarketingManagerCampaignsNotifier extends StateNotifier<MarketingManagerCampaignsModel> {
  MarketingManagerCampaignsNotifier() : super(const MarketingManagerCampaignsModel(isLoading: true));

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

final marketing_manager_campaignsProvider = StateNotifierProvider<MarketingManagerCampaignsNotifier, MarketingManagerCampaignsModel>((ref) {
  return MarketingManagerCampaignsNotifier()..loadData();
});
