import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/integration_health_monitor_model.dart';

class IntegrationHealthMonitorNotifier extends StateNotifier<IntegrationHealthMonitorModel> {
  IntegrationHealthMonitorNotifier() : super(const IntegrationHealthMonitorModel(isLoading: true));

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

final integration_health_monitorProvider = StateNotifierProvider<IntegrationHealthMonitorNotifier, IntegrationHealthMonitorModel>((ref) {
  return IntegrationHealthMonitorNotifier()..loadData();
});
