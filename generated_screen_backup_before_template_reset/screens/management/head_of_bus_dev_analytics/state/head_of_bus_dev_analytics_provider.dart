import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/head_of_bus_dev_analytics_model.dart';

class HeadOfBusDevAnalyticsNotifier extends StateNotifier<HeadOfBusDevAnalyticsModel> {
  HeadOfBusDevAnalyticsNotifier() : super(const HeadOfBusDevAnalyticsModel(isLoading: true));

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

final head_of_bus_dev_analyticsProvider = StateNotifierProvider<HeadOfBusDevAnalyticsNotifier, HeadOfBusDevAnalyticsModel>((ref) {
  return HeadOfBusDevAnalyticsNotifier()..loadData();
});
