import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FailedWorkflowScreenState
    extends DashboardState<FailedWorkflowScreenState> {
  FailedWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FailedWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      FailedWorkflowScreenState(isLoading: isLoading, error: error, data: data);
}

class FailedWorkflowScreenController
    extends BaseDashboardController<FailedWorkflowScreenState> {
  FailedWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: FailedWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/staff/failed-workflow',
      );
}

final failed_workflowControllerProvider =
    StateNotifierProvider<
      FailedWorkflowScreenController,
      FailedWorkflowScreenState
    >((ref) {
      return FailedWorkflowScreenController(ref);
    });
