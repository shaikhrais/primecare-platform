import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerCommandCenterScreenState
    extends DashboardState<SchedulerCommandCenterScreenState> {
  SchedulerCommandCenterScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SchedulerCommandCenterScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SchedulerCommandCenterScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SchedulerCommandCenterScreenController
    extends BaseDashboardController<SchedulerCommandCenterScreenState> {
  SchedulerCommandCenterScreenController(Ref ref)
    : super(
        ref,
        initialState: SchedulerCommandCenterScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/scheduler-command-center',
      );
}

final scheduler_command_centerControllerProvider =
    StateNotifierProvider<
      SchedulerCommandCenterScreenController,
      SchedulerCommandCenterScreenState
    >((ref) {
      return SchedulerCommandCenterScreenController(ref);
    });
