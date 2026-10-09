import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerCalendarScreenState
    extends DashboardState<SchedulerCalendarScreenState> {
  SchedulerCalendarScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SchedulerCalendarScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SchedulerCalendarScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SchedulerCalendarScreenController
    extends BaseDashboardController<SchedulerCalendarScreenState> {
  SchedulerCalendarScreenController(Ref ref)
    : super(
        ref,
        initialState: SchedulerCalendarScreenState(isLoading: true, data: {}),
        endpoint: '/staff/scheduler-calendar',
      );
}

final scheduler_calendarControllerProvider =
    StateNotifierProvider<
      SchedulerCalendarScreenController,
      SchedulerCalendarScreenState
    >((ref) {
      return SchedulerCalendarScreenController(ref);
    });
