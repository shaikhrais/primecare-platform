import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/territory_expansion_manager_analytics_model.dart';

class TerritoryExpansionManagerAnalyticsNotifier extends StateNotifier<TerritoryExpansionManagerAnalyticsModel> {
  TerritoryExpansionManagerAnalyticsNotifier() : super(const TerritoryExpansionManagerAnalyticsModel(isLoading: true));

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

final territory_expansion_manager_analyticsProvider = StateNotifierProvider<TerritoryExpansionManagerAnalyticsNotifier, TerritoryExpansionManagerAnalyticsModel>((ref) {
  return TerritoryExpansionManagerAnalyticsNotifier()..loadData();
});
