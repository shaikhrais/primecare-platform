import 'package:flutter_riverpod/legacy.dart';
import '../models/local_marketing_manager_campaigns_model.dart';

class LocalMarketingManagerCampaignsNotifier extends StateNotifier<LocalMarketingManagerCampaignsModel> {
  LocalMarketingManagerCampaignsNotifier() : super(const LocalMarketingManagerCampaignsModel(isLoading: true));

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

final local_marketing_manager_campaignsProvider = StateNotifierProvider<LocalMarketingManagerCampaignsNotifier, LocalMarketingManagerCampaignsModel>((ref) {
  return LocalMarketingManagerCampaignsNotifier()..loadData();
});
