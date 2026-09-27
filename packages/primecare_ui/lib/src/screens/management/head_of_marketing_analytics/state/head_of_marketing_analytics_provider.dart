import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/head_of_marketing_analytics_model.dart';

class HeadOfMarketingAnalyticsNotifier extends StateNotifier<HeadOfMarketingAnalyticsModel> {
  HeadOfMarketingAnalyticsNotifier() : super(const HeadOfMarketingAnalyticsModel(isLoading: true));

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

final head_of_marketing_analyticsProvider = StateNotifierProvider<HeadOfMarketingAnalyticsNotifier, HeadOfMarketingAnalyticsModel>((ref) {
  return HeadOfMarketingAnalyticsNotifier()..loadData();
});
