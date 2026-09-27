import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_analytics_model.dart';

class FranchiseAnalyticsNotifier extends StateNotifier<FranchiseAnalyticsModel> {
  FranchiseAnalyticsNotifier() : super(const FranchiseAnalyticsModel(isLoading: true));

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

final franchise_analyticsProvider = StateNotifierProvider<FranchiseAnalyticsNotifier, FranchiseAnalyticsModel>((ref) {
  return FranchiseAnalyticsNotifier()..loadData();
});
