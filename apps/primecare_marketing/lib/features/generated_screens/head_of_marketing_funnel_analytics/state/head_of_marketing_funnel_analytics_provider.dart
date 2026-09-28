import 'package:flutter_riverpod/legacy.dart';
import '../models/head_of_marketing_funnel_analytics_model.dart';

class HeadOfMarketingFunnelAnalyticsNotifier extends StateNotifier<HeadOfMarketingFunnelAnalyticsModel> {
  HeadOfMarketingFunnelAnalyticsNotifier() : super(const HeadOfMarketingFunnelAnalyticsModel(isLoading: true));

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

final head_of_marketing_funnel_analyticsProvider = StateNotifierProvider<HeadOfMarketingFunnelAnalyticsNotifier, HeadOfMarketingFunnelAnalyticsModel>((ref) {
  return HeadOfMarketingFunnelAnalyticsNotifier()..loadData();
});
