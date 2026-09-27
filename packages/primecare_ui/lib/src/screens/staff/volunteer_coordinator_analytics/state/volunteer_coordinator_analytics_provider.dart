import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/volunteer_coordinator_analytics_model.dart';

class VolunteerCoordinatorAnalyticsNotifier extends StateNotifier<VolunteerCoordinatorAnalyticsModel> {
  VolunteerCoordinatorAnalyticsNotifier() : super(const VolunteerCoordinatorAnalyticsModel(isLoading: true));

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

final volunteer_coordinator_analyticsProvider = StateNotifierProvider<VolunteerCoordinatorAnalyticsNotifier, VolunteerCoordinatorAnalyticsModel>((ref) {
  return VolunteerCoordinatorAnalyticsNotifier()..loadData();
});
