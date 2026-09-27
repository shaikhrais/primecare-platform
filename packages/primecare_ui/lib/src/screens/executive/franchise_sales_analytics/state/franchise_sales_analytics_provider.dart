import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_sales_analytics_model.dart';

class FranchiseSalesAnalyticsNotifier extends StateNotifier<FranchiseSalesAnalyticsModel> {
  FranchiseSalesAnalyticsNotifier() : super(const FranchiseSalesAnalyticsModel(isLoading: true));

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

final franchise_sales_analyticsProvider = StateNotifierProvider<FranchiseSalesAnalyticsNotifier, FranchiseSalesAnalyticsModel>((ref) {
  return FranchiseSalesAnalyticsNotifier()..loadData();
});
