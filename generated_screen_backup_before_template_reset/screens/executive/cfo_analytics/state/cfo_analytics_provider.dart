import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cfo_analytics_model.dart';

class CfoAnalyticsNotifier extends StateNotifier<CfoAnalyticsModel> {
  CfoAnalyticsNotifier() : super(const CfoAnalyticsModel(isLoading: true));

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

final cfo_analyticsProvider = StateNotifierProvider<CfoAnalyticsNotifier, CfoAnalyticsModel>((ref) {
  return CfoAnalyticsNotifier()..loadData();
});
