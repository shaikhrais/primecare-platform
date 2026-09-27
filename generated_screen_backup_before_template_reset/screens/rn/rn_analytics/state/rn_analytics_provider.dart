import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rn_analytics_model.dart';

class RnAnalyticsNotifier extends StateNotifier<RnAnalyticsModel> {
  RnAnalyticsNotifier() : super(const RnAnalyticsModel(isLoading: true));

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

final rn_analyticsProvider = StateNotifierProvider<RnAnalyticsNotifier, RnAnalyticsModel>((ref) {
  return RnAnalyticsNotifier()..loadData();
});
