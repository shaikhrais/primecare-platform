import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lpn_analytics_model.dart';

class LpnAnalyticsNotifier extends StateNotifier<LpnAnalyticsModel> {
  LpnAnalyticsNotifier() : super(const LpnAnalyticsModel(isLoading: true));

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

final lpn_analyticsProvider = StateNotifierProvider<LpnAnalyticsNotifier, LpnAnalyticsModel>((ref) {
  return LpnAnalyticsNotifier()..loadData();
});
