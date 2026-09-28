import 'package:flutter_riverpod/legacy.dart';
import '../models/cto_api_monitoring_model.dart';

class CtoApiMonitoringNotifier extends StateNotifier<CtoApiMonitoringModel> {
  CtoApiMonitoringNotifier() : super(const CtoApiMonitoringModel(isLoading: true));

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

final cto_api_monitoringProvider = StateNotifierProvider<CtoApiMonitoringNotifier, CtoApiMonitoringModel>((ref) {
  return CtoApiMonitoringNotifier()..loadData();
});
