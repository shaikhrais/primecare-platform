import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rn_field_supervisor_analytics_model.dart';

class RnFieldSupervisorAnalyticsNotifier extends StateNotifier<RnFieldSupervisorAnalyticsModel> {
  RnFieldSupervisorAnalyticsNotifier() : super(const RnFieldSupervisorAnalyticsModel(isLoading: true));

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

final rn_field_supervisor_analyticsProvider = StateNotifierProvider<RnFieldSupervisorAnalyticsNotifier, RnFieldSupervisorAnalyticsModel>((ref) {
  return RnFieldSupervisorAnalyticsNotifier()..loadData();
});
