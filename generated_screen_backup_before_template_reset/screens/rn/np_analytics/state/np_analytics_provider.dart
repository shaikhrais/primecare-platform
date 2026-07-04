import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/np_analytics_model.dart';

class NpAnalyticsNotifier extends StateNotifier<NpAnalyticsModel> {
  NpAnalyticsNotifier() : super(const NpAnalyticsModel(isLoading: true));

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

final np_analyticsProvider = StateNotifierProvider<NpAnalyticsNotifier, NpAnalyticsModel>((ref) {
  return NpAnalyticsNotifier()..loadData();
});
