import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceScreenState extends DashboardState<AttendanceScreenState> {
  AttendanceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  AttendanceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => AttendanceScreenState(isLoading: isLoading, error: error, data: data);
}

class AttendanceScreenController
    extends BaseDashboardController<AttendanceScreenState> {
  AttendanceScreenController(Ref ref)
    : super(
        ref,
        initialState: AttendanceScreenState(isLoading: true, data: {}),
        endpoint: '/management/attendance',
      );
}

final attendanceControllerProvider =
    StateNotifierProvider<AttendanceScreenController, AttendanceScreenState>((
      ref,
    ) {
      return AttendanceScreenController(ref);
    });
