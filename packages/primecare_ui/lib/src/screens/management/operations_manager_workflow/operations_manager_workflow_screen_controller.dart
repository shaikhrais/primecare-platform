import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OperationsManagerWorkflowScreenState
    extends DashboardState<OperationsManagerWorkflowScreenState> {
  OperationsManagerWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  OperationsManagerWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => OperationsManagerWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class OperationsManagerWorkflowScreenController
    extends BaseDashboardController<OperationsManagerWorkflowScreenState> {
  OperationsManagerWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: OperationsManagerWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/operations-manager-workflow',
      );
}

final operations_manager_workflowControllerProvider =
    StateNotifierProvider<
      OperationsManagerWorkflowScreenController,
      OperationsManagerWorkflowScreenState
    >((ref) {
      return OperationsManagerWorkflowScreenController(ref);
    });
