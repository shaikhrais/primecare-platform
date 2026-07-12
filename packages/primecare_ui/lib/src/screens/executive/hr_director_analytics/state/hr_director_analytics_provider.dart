import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_director_analytics_model.dart';

class HrDirectorAnalyticsNotifier extends StateNotifier<HrDirectorAnalyticsModel> {
  HrDirectorAnalyticsNotifier() : super(const HrDirectorAnalyticsModel(isLoading: true));

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

final hr_director_analyticsProvider = StateNotifierProvider<HrDirectorAnalyticsNotifier, HrDirectorAnalyticsModel>((ref) {
  return HrDirectorAnalyticsNotifier()..loadData();
});
