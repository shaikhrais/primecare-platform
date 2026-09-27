import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/general_manager_analytics_model.dart';

class GeneralManagerAnalyticsNotifier extends StateNotifier<GeneralManagerAnalyticsModel> {
  GeneralManagerAnalyticsNotifier() : super(const GeneralManagerAnalyticsModel(isLoading: true));

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

final general_manager_analyticsProvider = StateNotifierProvider<GeneralManagerAnalyticsNotifier, GeneralManagerAnalyticsModel>((ref) {
  return GeneralManagerAnalyticsNotifier()..loadData();
});
