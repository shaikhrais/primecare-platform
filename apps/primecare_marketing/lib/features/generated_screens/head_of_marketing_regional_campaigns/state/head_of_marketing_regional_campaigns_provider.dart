import 'package:flutter_riverpod/legacy.dart';
import '../models/head_of_marketing_regional_campaigns_model.dart';

class HeadOfMarketingRegionalCampaignsNotifier extends StateNotifier<HeadOfMarketingRegionalCampaignsModel> {
  HeadOfMarketingRegionalCampaignsNotifier() : super(const HeadOfMarketingRegionalCampaignsModel(isLoading: true));

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

final head_of_marketing_regional_campaignsProvider = StateNotifierProvider<HeadOfMarketingRegionalCampaignsNotifier, HeadOfMarketingRegionalCampaignsModel>((ref) {
  return HeadOfMarketingRegionalCampaignsNotifier()..loadData();
});
