import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/business_development_analytics_model.dart';

class BusinessDevelopmentAnalyticsNotifier extends StateNotifier<BusinessDevelopmentAnalyticsModel> {
  BusinessDevelopmentAnalyticsNotifier() : super(const BusinessDevelopmentAnalyticsModel(isLoading: true));

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

final business_development_analyticsProvider = StateNotifierProvider<BusinessDevelopmentAnalyticsNotifier, BusinessDevelopmentAnalyticsModel>((ref) {
  return BusinessDevelopmentAnalyticsNotifier()..loadData();
});
