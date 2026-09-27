import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/regional_manager_usa_analytics_model.dart';

class RegionalManagerUsaAnalyticsNotifier extends StateNotifier<RegionalManagerUsaAnalyticsModel> {
  RegionalManagerUsaAnalyticsNotifier() : super(const RegionalManagerUsaAnalyticsModel(isLoading: true));

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

final regional_manager_usa_analyticsProvider = StateNotifierProvider<RegionalManagerUsaAnalyticsNotifier, RegionalManagerUsaAnalyticsModel>((ref) {
  return RegionalManagerUsaAnalyticsNotifier()..loadData();
});
