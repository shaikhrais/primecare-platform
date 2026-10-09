import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfrastructureWorkflowScreenState
    extends DashboardState<InfrastructureWorkflowScreenState> {
  InfrastructureWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  InfrastructureWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => InfrastructureWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class InfrastructureWorkflowScreenController
    extends BaseDashboardController<InfrastructureWorkflowScreenState> {
  InfrastructureWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: InfrastructureWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/infrastructure-workflow',
      );
}

final infrastructure_workflowControllerProvider =
    StateNotifierProvider<
      InfrastructureWorkflowScreenController,
      InfrastructureWorkflowScreenState
    >((ref) {
      return InfrastructureWorkflowScreenController(ref);
    });
