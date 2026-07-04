import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_system_logs_model.dart';

class PswSystemLogsNotifier extends StateNotifier<PswSystemLogsModel> {
  PswSystemLogsNotifier() : super(const PswSystemLogsModel(isLoading: true));

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

final psw_system_logsProvider = StateNotifierProvider<PswSystemLogsNotifier, PswSystemLogsModel>((ref) {
  return PswSystemLogsNotifier()..loadData();
});
