import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleScreenState extends DashboardState<ScheduleScreenState> {
  ScheduleScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ScheduleScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ScheduleScreenState(isLoading: isLoading, error: error, data: data);
}

class ScheduleScreenController
    extends BaseDashboardController<ScheduleScreenState> {
  ScheduleScreenController(Ref ref)
    : super(
        ref,
        initialState: ScheduleScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/caregiver/psw-schedule',
      );
}

final scheduleControllerProvider =
    StateNotifierProvider<ScheduleScreenController, ScheduleScreenState>((ref) {
      return ScheduleScreenController(ref);
    });
