import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerOpenShiftsScreenState
    extends DashboardState<SchedulerOpenShiftsScreenState> {
  SchedulerOpenShiftsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SchedulerOpenShiftsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SchedulerOpenShiftsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SchedulerOpenShiftsScreenController
    extends BaseDashboardController<SchedulerOpenShiftsScreenState> {
  SchedulerOpenShiftsScreenController(Ref ref)
    : super(
        ref,
        initialState: SchedulerOpenShiftsScreenState(isLoading: true, data: {}),
        endpoint: '/staff/scheduler-open-shifts',
      );
}

final scheduler_open_shiftsControllerProvider =
    StateNotifierProvider<
      SchedulerOpenShiftsScreenController,
      SchedulerOpenShiftsScreenState
    >((ref) {
      return SchedulerOpenShiftsScreenController(ref);
    });
