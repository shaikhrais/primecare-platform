import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lead_analytics_model.dart';

class LeadAnalyticsNotifier extends StateNotifier<LeadAnalyticsModel> {
  LeadAnalyticsNotifier() : super(const LeadAnalyticsModel(isLoading: true));

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

final lead_analyticsProvider = StateNotifierProvider<LeadAnalyticsNotifier, LeadAnalyticsModel>((ref) {
  return LeadAnalyticsNotifier()..loadData();
});
