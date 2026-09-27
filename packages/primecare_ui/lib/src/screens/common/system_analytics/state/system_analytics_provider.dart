import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/system_analytics_model.dart';

class SystemAnalyticsNotifier extends StateNotifier<SystemAnalyticsModel> {
  SystemAnalyticsNotifier() : super(const SystemAnalyticsModel(isLoading: true));

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

final system_analyticsProvider = StateNotifierProvider<SystemAnalyticsNotifier, SystemAnalyticsModel>((ref) {
  return SystemAnalyticsNotifier()..loadData();
});
