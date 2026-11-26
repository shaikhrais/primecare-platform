import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkflowExecutionScreenState
    extends DashboardState<WorkflowExecutionScreenState> {
  WorkflowExecutionScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  WorkflowExecutionScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => WorkflowExecutionScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class WorkflowExecutionScreenController
    extends BaseDashboardController<WorkflowExecutionScreenState> {
  WorkflowExecutionScreenController(Ref ref)
    : super(
        ref,
        initialState: WorkflowExecutionScreenState(isLoading: true, data: {}),
        endpoint: '/common/workflow-execution',
      );
}

final workflow_executionControllerProvider =
    StateNotifierProvider<
      WorkflowExecutionScreenController,
      WorkflowExecutionScreenState
    >((ref) {
      return WorkflowExecutionScreenController(ref);
    });
