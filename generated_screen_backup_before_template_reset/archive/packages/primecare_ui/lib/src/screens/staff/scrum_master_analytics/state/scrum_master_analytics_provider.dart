import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scrum_master_analytics_model.dart';

class ScrumMasterAnalyticsNotifier extends StateNotifier<ScrumMasterAnalyticsModel> {
  ScrumMasterAnalyticsNotifier() : super(const ScrumMasterAnalyticsModel(isLoading: true));

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

final scrum_master_analyticsProvider = StateNotifierProvider<ScrumMasterAnalyticsNotifier, ScrumMasterAnalyticsModel>((ref) {
  return ScrumMasterAnalyticsNotifier()..loadData();
});
