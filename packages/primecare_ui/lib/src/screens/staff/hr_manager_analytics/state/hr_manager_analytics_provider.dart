import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_manager_analytics_model.dart';

class HrManagerAnalyticsNotifier extends StateNotifier<HrManagerAnalyticsModel> {
  HrManagerAnalyticsNotifier() : super(const HrManagerAnalyticsModel(isLoading: true));

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

final hr_manager_analyticsProvider = StateNotifierProvider<HrManagerAnalyticsNotifier, HrManagerAnalyticsModel>((ref) {
  return HrManagerAnalyticsNotifier()..loadData();
});
