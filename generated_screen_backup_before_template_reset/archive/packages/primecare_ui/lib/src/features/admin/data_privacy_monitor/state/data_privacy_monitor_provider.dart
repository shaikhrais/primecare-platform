import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/data_privacy_monitor_model.dart';

class DataPrivacyMonitorNotifier extends StateNotifier<DataPrivacyMonitorModel> {
  DataPrivacyMonitorNotifier() : super(const DataPrivacyMonitorModel(isLoading: true));

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

final data_privacy_monitorProvider = StateNotifierProvider<DataPrivacyMonitorNotifier, DataPrivacyMonitorModel>((ref) {
  return DataPrivacyMonitorNotifier()..loadData();
});
