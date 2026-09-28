import 'package:flutter_riverpod/legacy.dart';
import '../models/monitoring_model.dart';

class MonitoringNotifier extends StateNotifier<MonitoringModel> {
  MonitoringNotifier() : super(const MonitoringModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final monitoringProvider = StateNotifierProvider<MonitoringNotifier, MonitoringModel>((ref) {
  return MonitoringNotifier()..loadData();
});
