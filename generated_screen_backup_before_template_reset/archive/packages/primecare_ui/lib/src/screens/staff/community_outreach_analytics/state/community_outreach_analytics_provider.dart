import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/community_outreach_analytics_model.dart';

class CommunityOutreachAnalyticsNotifier extends StateNotifier<CommunityOutreachAnalyticsModel> {
  CommunityOutreachAnalyticsNotifier() : super(const CommunityOutreachAnalyticsModel(isLoading: true));

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

final community_outreach_analyticsProvider = StateNotifierProvider<CommunityOutreachAnalyticsNotifier, CommunityOutreachAnalyticsModel>((ref) {
  return CommunityOutreachAnalyticsNotifier()..loadData();
});
