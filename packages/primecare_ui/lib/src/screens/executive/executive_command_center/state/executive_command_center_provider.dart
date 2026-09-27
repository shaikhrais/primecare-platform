import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/executive_command_center_model.dart';

class ExecutiveCommandCenterNotifier extends StateNotifier<ExecutiveCommandCenterModel> {
  ExecutiveCommandCenterNotifier() : super(const ExecutiveCommandCenterModel(isLoading: true));

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

final executive_command_centerProvider = StateNotifierProvider<ExecutiveCommandCenterNotifier, ExecutiveCommandCenterModel>((ref) {
  return ExecutiveCommandCenterNotifier()..loadData();
});
