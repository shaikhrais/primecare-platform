import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vip_manager_analytics_model.dart';

class VipManagerAnalyticsNotifier extends StateNotifier<VipManagerAnalyticsModel> {
  VipManagerAnalyticsNotifier() : super(const VipManagerAnalyticsModel(isLoading: true));

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

final vip_manager_analyticsProvider = StateNotifierProvider<VipManagerAnalyticsNotifier, VipManagerAnalyticsModel>((ref) {
  return VipManagerAnalyticsNotifier()..loadData();
});
