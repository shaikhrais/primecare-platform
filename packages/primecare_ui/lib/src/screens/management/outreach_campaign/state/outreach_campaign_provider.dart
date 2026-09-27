import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/outreach_campaign_model.dart';

class OutreachCampaignNotifier extends StateNotifier<OutreachCampaignModel> {
  OutreachCampaignNotifier() : super(const OutreachCampaignModel(isLoading: true));

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

final outreach_campaignProvider = StateNotifierProvider<OutreachCampaignNotifier, OutreachCampaignModel>((ref) {
  return OutreachCampaignNotifier()..loadData();
});
