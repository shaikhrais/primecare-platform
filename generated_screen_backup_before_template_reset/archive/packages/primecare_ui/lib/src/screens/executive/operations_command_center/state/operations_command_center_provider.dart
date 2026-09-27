import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/operations_command_center_model.dart';

class OperationsCommandCenterNotifier extends StateNotifier<OperationsCommandCenterModel> {
  OperationsCommandCenterNotifier() : super(const OperationsCommandCenterModel(isLoading: true));

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

final operations_command_centerProvider = StateNotifierProvider<OperationsCommandCenterNotifier, OperationsCommandCenterModel>((ref) {
  return OperationsCommandCenterNotifier()..loadData();
});
