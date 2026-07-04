import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/governance_officer_analytics_model.dart';

class GovernanceOfficerAnalyticsNotifier extends StateNotifier<GovernanceOfficerAnalyticsModel> {
  GovernanceOfficerAnalyticsNotifier() : super(const GovernanceOfficerAnalyticsModel(isLoading: true));

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

final governance_officer_analyticsProvider = StateNotifierProvider<GovernanceOfficerAnalyticsNotifier, GovernanceOfficerAnalyticsModel>((ref) {
  return GovernanceOfficerAnalyticsNotifier()..loadData();
});
