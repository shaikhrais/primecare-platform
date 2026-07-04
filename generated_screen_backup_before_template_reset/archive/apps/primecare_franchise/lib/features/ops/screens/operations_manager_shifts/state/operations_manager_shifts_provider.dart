import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/operations_manager_shifts_model.dart';

class OperationsManagerShiftsNotifier extends StateNotifier<OperationsManagerShiftsModel> {
  OperationsManagerShiftsNotifier() : super(const OperationsManagerShiftsModel(isLoading: true));

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

final operations_manager_shiftsProvider = StateNotifierProvider<OperationsManagerShiftsNotifier, OperationsManagerShiftsModel>((ref) {
  return OperationsManagerShiftsNotifier()..loadData();
});
