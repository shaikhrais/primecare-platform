import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerWorkflowScreenState
    extends DashboardState<SchedulerWorkflowScreenState> {
  SchedulerWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SchedulerWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SchedulerWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SchedulerWorkflowScreenController
    extends BaseDashboardController<SchedulerWorkflowScreenState> {
  SchedulerWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: SchedulerWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/staff/scheduler-workflow',
      );
}

final scheduler_workflowControllerProvider =
    StateNotifierProvider<
      SchedulerWorkflowScreenController,
      SchedulerWorkflowScreenState
    >((ref) {
      return SchedulerWorkflowScreenController(ref);
    });
