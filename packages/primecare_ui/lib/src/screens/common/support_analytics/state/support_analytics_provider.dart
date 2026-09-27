import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/support_analytics_model.dart';

class SupportAnalyticsNotifier extends StateNotifier<SupportAnalyticsModel> {
  SupportAnalyticsNotifier() : super(const SupportAnalyticsModel(isLoading: true));

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

final support_analyticsProvider = StateNotifierProvider<SupportAnalyticsNotifier, SupportAnalyticsModel>((ref) {
  return SupportAnalyticsNotifier()..loadData();
});
