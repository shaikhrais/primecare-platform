import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/billing_admin_analytics_model.dart';

class BillingAdminAnalyticsNotifier extends StateNotifier<BillingAdminAnalyticsModel> {
  BillingAdminAnalyticsNotifier() : super(const BillingAdminAnalyticsModel(isLoading: true));

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

final billing_admin_analyticsProvider = StateNotifierProvider<BillingAdminAnalyticsNotifier, BillingAdminAnalyticsModel>((ref) {
  return BillingAdminAnalyticsNotifier()..loadData();
});
