import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/premium_concierge_analytics_model.dart';

class PremiumConciergeAnalyticsNotifier extends StateNotifier<PremiumConciergeAnalyticsModel> {
  PremiumConciergeAnalyticsNotifier() : super(const PremiumConciergeAnalyticsModel(isLoading: true));

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

final premium_concierge_analyticsProvider = StateNotifierProvider<PremiumConciergeAnalyticsNotifier, PremiumConciergeAnalyticsModel>((ref) {
  return PremiumConciergeAnalyticsNotifier()..loadData();
});
