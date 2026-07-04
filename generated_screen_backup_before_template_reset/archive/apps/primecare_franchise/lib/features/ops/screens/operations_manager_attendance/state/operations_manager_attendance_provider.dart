import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/operations_manager_attendance_model.dart';

class OperationsManagerAttendanceNotifier extends StateNotifier<OperationsManagerAttendanceModel> {
  OperationsManagerAttendanceNotifier() : super(const OperationsManagerAttendanceModel(isLoading: true));

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

final operations_manager_attendanceProvider = StateNotifierProvider<OperationsManagerAttendanceNotifier, OperationsManagerAttendanceModel>((ref) {
  return OperationsManagerAttendanceNotifier()..loadData();
});
