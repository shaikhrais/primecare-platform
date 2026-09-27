import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/social_worker_analytics_model.dart';

class SocialWorkerAnalyticsNotifier extends StateNotifier<SocialWorkerAnalyticsModel> {
  SocialWorkerAnalyticsNotifier() : super(const SocialWorkerAnalyticsModel(isLoading: true));

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

final social_worker_analyticsProvider = StateNotifierProvider<SocialWorkerAnalyticsNotifier, SocialWorkerAnalyticsModel>((ref) {
  return SocialWorkerAnalyticsNotifier()..loadData();
});
