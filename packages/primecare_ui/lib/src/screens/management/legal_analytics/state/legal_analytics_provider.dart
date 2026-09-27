import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/legal_analytics_model.dart';

class LegalAnalyticsNotifier extends StateNotifier<LegalAnalyticsModel> {
  LegalAnalyticsNotifier() : super(const LegalAnalyticsModel(isLoading: true));

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

final legal_analyticsProvider = StateNotifierProvider<LegalAnalyticsNotifier, LegalAnalyticsModel>((ref) {
  return LegalAnalyticsNotifier()..loadData();
});
