import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheduler_command_center_model.dart';

class SchedulerCommandCenterNotifier extends StateNotifier<SchedulerCommandCenterModel> {
  SchedulerCommandCenterNotifier() : super(const SchedulerCommandCenterModel(isLoading: true));

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

final scheduler_command_centerProvider = StateNotifierProvider<SchedulerCommandCenterNotifier, SchedulerCommandCenterModel>((ref) {
  return SchedulerCommandCenterNotifier()..loadData();
});
