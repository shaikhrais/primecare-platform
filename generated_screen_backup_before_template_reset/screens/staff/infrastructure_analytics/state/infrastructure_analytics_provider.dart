import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/infrastructure_analytics_model.dart';

class InfrastructureAnalyticsNotifier extends StateNotifier<InfrastructureAnalyticsModel> {
  InfrastructureAnalyticsNotifier() : super(const InfrastructureAnalyticsModel(isLoading: true));

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

final infrastructure_analyticsProvider = StateNotifierProvider<InfrastructureAnalyticsNotifier, InfrastructureAnalyticsModel>((ref) {
  return InfrastructureAnalyticsNotifier()..loadData();
});
