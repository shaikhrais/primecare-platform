import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/api_monitoring_model.dart';

class ApiMonitoringNotifier extends StateNotifier<ApiMonitoringModel> {
  ApiMonitoringNotifier() : super(const ApiMonitoringModel(isLoading: true));

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

final api_monitoringProvider = StateNotifierProvider<ApiMonitoringNotifier, ApiMonitoringModel>((ref) {
  return ApiMonitoringNotifier()..loadData();
});
