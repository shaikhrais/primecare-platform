import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/regional_bdm_analytics_model.dart';

class RegionalBdmAnalyticsNotifier extends StateNotifier<RegionalBdmAnalyticsModel> {
  RegionalBdmAnalyticsNotifier() : super(const RegionalBdmAnalyticsModel(isLoading: true));

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

final regional_bdm_analyticsProvider = StateNotifierProvider<RegionalBdmAnalyticsNotifier, RegionalBdmAnalyticsModel>((ref) {
  return RegionalBdmAnalyticsNotifier()..loadData();
});
