import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rmt_analytics_model.dart';

class RmtAnalyticsNotifier extends StateNotifier<RmtAnalyticsModel> {
  RmtAnalyticsNotifier() : super(const RmtAnalyticsModel(isLoading: true));

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

final rmt_analyticsProvider = StateNotifierProvider<RmtAnalyticsNotifier, RmtAnalyticsModel>((ref) {
  return RmtAnalyticsNotifier()..loadData();
});
