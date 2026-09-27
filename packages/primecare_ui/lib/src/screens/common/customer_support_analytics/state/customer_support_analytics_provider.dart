import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/customer_support_analytics_model.dart';

class CustomerSupportAnalyticsNotifier extends StateNotifier<CustomerSupportAnalyticsModel> {
  CustomerSupportAnalyticsNotifier() : super(const CustomerSupportAnalyticsModel(isLoading: true));

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

final customer_support_analyticsProvider = StateNotifierProvider<CustomerSupportAnalyticsNotifier, CustomerSupportAnalyticsModel>((ref) {
  return CustomerSupportAnalyticsNotifier()..loadData();
});
