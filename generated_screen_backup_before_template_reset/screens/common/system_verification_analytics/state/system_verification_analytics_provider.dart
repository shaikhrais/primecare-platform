import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/system_verification_analytics_model.dart';

class SystemVerificationAnalyticsNotifier extends StateNotifier<SystemVerificationAnalyticsModel> {
  SystemVerificationAnalyticsNotifier() : super(const SystemVerificationAnalyticsModel(isLoading: true));

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

final system_verification_analyticsProvider = StateNotifierProvider<SystemVerificationAnalyticsNotifier, SystemVerificationAnalyticsModel>((ref) {
  return SystemVerificationAnalyticsNotifier()..loadData();
});
