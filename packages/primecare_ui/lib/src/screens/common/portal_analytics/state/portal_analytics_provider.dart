import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/portal_analytics_model.dart';

class PortalAnalyticsNotifier extends StateNotifier<PortalAnalyticsModel> {
  PortalAnalyticsNotifier() : super(const PortalAnalyticsModel(isLoading: true));

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

final portal_analyticsProvider = StateNotifierProvider<PortalAnalyticsNotifier, PortalAnalyticsModel>((ref) {
  return PortalAnalyticsNotifier()..loadData();
});
