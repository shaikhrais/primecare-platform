import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorWorkflowScreenState
    extends DashboardState<IntakeCoordinatorWorkflowScreenState> {
  IntakeCoordinatorWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  IntakeCoordinatorWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class IntakeCoordinatorWorkflowScreenController
    extends BaseDashboardController<IntakeCoordinatorWorkflowScreenState> {
  IntakeCoordinatorWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: IntakeCoordinatorWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint:
            '/offices/clinical/roles/intake_coordinator/coordinator-workflow',
      );
}

final intake_coordinator_workflowControllerProvider =
    StateNotifierProvider<
      IntakeCoordinatorWorkflowScreenController,
      IntakeCoordinatorWorkflowScreenState
    >((ref) {
      return IntakeCoordinatorWorkflowScreenController(ref);
    });
