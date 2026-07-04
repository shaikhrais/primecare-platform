import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_coordinator_attendance_model.dart';

class TrainingCoordinatorAttendanceNotifier extends StateNotifier<TrainingCoordinatorAttendanceModel> {
  TrainingCoordinatorAttendanceNotifier() : super(const TrainingCoordinatorAttendanceModel(isLoading: true));

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

final training_coordinator_attendanceProvider = StateNotifierProvider<TrainingCoordinatorAttendanceNotifier, TrainingCoordinatorAttendanceModel>((ref) {
  return TrainingCoordinatorAttendanceNotifier()..loadData();
});
