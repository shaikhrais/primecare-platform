import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rpn_analytics_model.dart';

class RpnAnalyticsNotifier extends StateNotifier<RpnAnalyticsModel> {
  RpnAnalyticsNotifier() : super(const RpnAnalyticsModel(isLoading: true));

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

final rpn_analyticsProvider = StateNotifierProvider<RpnAnalyticsNotifier, RpnAnalyticsModel>((ref) {
  return RpnAnalyticsNotifier()..loadData();
});
