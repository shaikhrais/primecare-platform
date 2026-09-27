import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/guest_analytics_model.dart';

class GuestAnalyticsNotifier extends StateNotifier<GuestAnalyticsModel> {
  GuestAnalyticsNotifier() : super(const GuestAnalyticsModel(isLoading: true));

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

final guest_analyticsProvider = StateNotifierProvider<GuestAnalyticsNotifier, GuestAnalyticsModel>((ref) {
  return GuestAnalyticsNotifier()..loadData();
});
