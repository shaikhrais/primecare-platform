import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinic_history_logs_model.dart';

class ClinicHistoryLogsNotifier extends StateNotifier<ClinicHistoryLogsModel> {
  ClinicHistoryLogsNotifier() : super(const ClinicHistoryLogsModel(isLoading: true));

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

final clinic_history_logsProvider = StateNotifierProvider<ClinicHistoryLogsNotifier, ClinicHistoryLogsModel>((ref) {
  return ClinicHistoryLogsNotifier()..loadData();
});
