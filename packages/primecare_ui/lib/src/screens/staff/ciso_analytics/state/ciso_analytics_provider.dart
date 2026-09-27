import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ciso_analytics_model.dart';

class CisoAnalyticsNotifier extends StateNotifier<CisoAnalyticsModel> {
  CisoAnalyticsNotifier() : super(const CisoAnalyticsModel(isLoading: true));

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

final ciso_analyticsProvider = StateNotifierProvider<CisoAnalyticsNotifier, CisoAnalyticsModel>((ref) {
  return CisoAnalyticsNotifier()..loadData();
});
