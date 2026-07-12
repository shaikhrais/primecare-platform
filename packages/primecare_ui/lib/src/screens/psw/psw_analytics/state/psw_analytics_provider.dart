import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_analytics_model.dart';

class PswAnalyticsNotifier extends StateNotifier<PswAnalyticsModel> {
  PswAnalyticsNotifier() : super(const PswAnalyticsModel(isLoading: true));

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

final psw_analyticsProvider = StateNotifierProvider<PswAnalyticsNotifier, PswAnalyticsModel>((ref) {
  return PswAnalyticsNotifier()..loadData();
});
