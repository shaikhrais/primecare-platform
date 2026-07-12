import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/local_marketing_manager_analytics_model.dart';

class LocalMarketingManagerAnalyticsNotifier extends StateNotifier<LocalMarketingManagerAnalyticsModel> {
  LocalMarketingManagerAnalyticsNotifier() : super(const LocalMarketingManagerAnalyticsModel(isLoading: true));

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

final local_marketing_manager_analyticsProvider = StateNotifierProvider<LocalMarketingManagerAnalyticsNotifier, LocalMarketingManagerAnalyticsModel>((ref) {
  return LocalMarketingManagerAnalyticsNotifier()..loadData();
});
