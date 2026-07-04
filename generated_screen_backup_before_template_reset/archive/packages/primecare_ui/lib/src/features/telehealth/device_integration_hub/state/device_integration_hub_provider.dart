import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/device_integration_hub_model.dart';

class DeviceIntegrationHubNotifier extends StateNotifier<DeviceIntegrationHubModel> {
  DeviceIntegrationHubNotifier() : super(const DeviceIntegrationHubModel(isLoading: true));

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

final device_integration_hubProvider = StateNotifierProvider<DeviceIntegrationHubNotifier, DeviceIntegrationHubModel>((ref) {
  return DeviceIntegrationHubNotifier()..loadData();
});
