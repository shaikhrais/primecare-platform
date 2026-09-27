import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_sales_manager_analytics_model.dart';

class FranchiseSalesManagerAnalyticsNotifier extends StateNotifier<FranchiseSalesManagerAnalyticsModel> {
  FranchiseSalesManagerAnalyticsNotifier() : super(const FranchiseSalesManagerAnalyticsModel(isLoading: true));

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

final franchise_sales_manager_analyticsProvider = StateNotifierProvider<FranchiseSalesManagerAnalyticsNotifier, FranchiseSalesManagerAnalyticsModel>((ref) {
  return FranchiseSalesManagerAnalyticsNotifier()..loadData();
});
