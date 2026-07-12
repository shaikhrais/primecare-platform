import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cns_analytics_model.dart';

class CnsAnalyticsNotifier extends StateNotifier<CnsAnalyticsModel> {
  CnsAnalyticsNotifier() : super(const CnsAnalyticsModel(isLoading: true));

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

final cns_analyticsProvider = StateNotifierProvider<CnsAnalyticsNotifier, CnsAnalyticsModel>((ref) {
  return CnsAnalyticsNotifier()..loadData();
});
