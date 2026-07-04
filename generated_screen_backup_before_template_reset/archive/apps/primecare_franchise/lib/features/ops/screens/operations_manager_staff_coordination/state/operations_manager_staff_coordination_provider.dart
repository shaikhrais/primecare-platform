import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/operations_manager_staff_coordination_model.dart';

class OperationsManagerStaffCoordinationNotifier extends StateNotifier<OperationsManagerStaffCoordinationModel> {
  OperationsManagerStaffCoordinationNotifier() : super(const OperationsManagerStaffCoordinationModel(isLoading: true));

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

final operations_manager_staff_coordinationProvider = StateNotifierProvider<OperationsManagerStaffCoordinationNotifier, OperationsManagerStaffCoordinationModel>((ref) {
  return OperationsManagerStaffCoordinationNotifier()..loadData();
});
