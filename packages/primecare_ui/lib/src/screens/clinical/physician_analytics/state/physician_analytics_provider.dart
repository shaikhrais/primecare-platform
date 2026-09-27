import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/physician_analytics_model.dart';

class PhysicianAnalyticsNotifier extends StateNotifier<PhysicianAnalyticsModel> {
  PhysicianAnalyticsNotifier() : super(const PhysicianAnalyticsModel(isLoading: true));

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

final physician_analyticsProvider = StateNotifierProvider<PhysicianAnalyticsNotifier, PhysicianAnalyticsModel>((ref) {
  return PhysicianAnalyticsNotifier()..loadData();
});
