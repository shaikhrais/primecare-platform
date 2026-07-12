import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dynamic_analytics_model.dart';

class DynamicAnalyticsNotifier extends StateNotifier<DynamicAnalyticsModel> {
  DynamicAnalyticsNotifier() : super(const DynamicAnalyticsModel(isLoading: true));

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

final dynamic_analyticsProvider = StateNotifierProvider<DynamicAnalyticsNotifier, DynamicAnalyticsModel>((ref) {
  return DynamicAnalyticsNotifier()..loadData();
});
