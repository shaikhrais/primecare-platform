import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/intake_coordinator_analytics_model.dart';

class IntakeCoordinatorAnalyticsNotifier extends StateNotifier<IntakeCoordinatorAnalyticsModel> {
  IntakeCoordinatorAnalyticsNotifier() : super(const IntakeCoordinatorAnalyticsModel(isLoading: true));

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

final intake_coordinator_analyticsProvider = StateNotifierProvider<IntakeCoordinatorAnalyticsNotifier, IntakeCoordinatorAnalyticsModel>((ref) {
  return IntakeCoordinatorAnalyticsNotifier()..loadData();
});
