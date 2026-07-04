import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/head_of_marketing_campaigns_model.dart';

class HeadOfMarketingCampaignsNotifier extends StateNotifier<HeadOfMarketingCampaignsModel> {
  HeadOfMarketingCampaignsNotifier() : super(const HeadOfMarketingCampaignsModel(isLoading: true));

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

final head_of_marketing_campaignsProvider = StateNotifierProvider<HeadOfMarketingCampaignsNotifier, HeadOfMarketingCampaignsModel>((ref) {
  return HeadOfMarketingCampaignsNotifier()..loadData();
});
