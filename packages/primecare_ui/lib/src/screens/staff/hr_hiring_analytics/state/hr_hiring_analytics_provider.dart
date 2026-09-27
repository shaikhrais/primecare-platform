import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_hiring_analytics_model.dart';

class HrHiringAnalyticsNotifier extends StateNotifier<HrHiringAnalyticsModel> {
  HrHiringAnalyticsNotifier() : super(const HrHiringAnalyticsModel(isLoading: true));

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

final hr_hiring_analyticsProvider = StateNotifierProvider<HrHiringAnalyticsNotifier, HrHiringAnalyticsModel>((ref) {
  return HrHiringAnalyticsNotifier()..loadData();
});
