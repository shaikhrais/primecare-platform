import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/attendance_model.dart';

class AttendanceNotifier extends StateNotifier<AttendanceModel> {
  AttendanceNotifier() : super(const AttendanceModel(isLoading: true));

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

final attendanceProvider = StateNotifierProvider<AttendanceNotifier, AttendanceModel>((ref) {
  return AttendanceNotifier()..loadData();
});
