import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/owner_analytics_model.dart';

class OwnerAnalyticsNotifier extends StateNotifier<OwnerAnalyticsModel> {
  OwnerAnalyticsNotifier() : super(const OwnerAnalyticsModel(isLoading: true));

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

final owner_analyticsProvider = StateNotifierProvider<OwnerAnalyticsNotifier, OwnerAnalyticsModel>((ref) {
  return OwnerAnalyticsNotifier()..loadData();
});
