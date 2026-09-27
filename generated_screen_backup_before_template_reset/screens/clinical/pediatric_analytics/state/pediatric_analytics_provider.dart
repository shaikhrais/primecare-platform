import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pediatric_analytics_model.dart';

class PediatricAnalyticsNotifier extends StateNotifier<PediatricAnalyticsModel> {
  PediatricAnalyticsNotifier() : super(const PediatricAnalyticsModel(isLoading: true));

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

final pediatric_analyticsProvider = StateNotifierProvider<PediatricAnalyticsNotifier, PediatricAnalyticsModel>((ref) {
  return PediatricAnalyticsNotifier()..loadData();
});
