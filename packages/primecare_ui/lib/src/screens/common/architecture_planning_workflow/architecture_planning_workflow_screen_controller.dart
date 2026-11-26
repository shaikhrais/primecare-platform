import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArchitecturePlanningWorkflowScreenState
    extends DashboardState<ArchitecturePlanningWorkflowScreenState> {
  ArchitecturePlanningWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ArchitecturePlanningWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ArchitecturePlanningWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ArchitecturePlanningWorkflowScreenController
    extends BaseDashboardController<ArchitecturePlanningWorkflowScreenState> {
  ArchitecturePlanningWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: ArchitecturePlanningWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/architecture-planning-workflow',
      );
}

final architecture_planning_workflowControllerProvider =
    StateNotifierProvider<
      ArchitecturePlanningWorkflowScreenController,
      ArchitecturePlanningWorkflowScreenState
    >((ref) {
      return ArchitecturePlanningWorkflowScreenController(ref);
    });
