import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/architecture_planning_analytics_model.dart';

class ArchitecturePlanningAnalyticsNotifier extends StateNotifier<ArchitecturePlanningAnalyticsModel> {
  ArchitecturePlanningAnalyticsNotifier() : super(const ArchitecturePlanningAnalyticsModel(isLoading: true));

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

final architecture_planning_analyticsProvider = StateNotifierProvider<ArchitecturePlanningAnalyticsNotifier, ArchitecturePlanningAnalyticsModel>((ref) {
  return ArchitecturePlanningAnalyticsNotifier()..loadData();
});
