import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeWorkflowScreenState
    extends DashboardState<IntakeWorkflowScreenState> {
  IntakeWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  IntakeWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      IntakeWorkflowScreenState(isLoading: isLoading, error: error, data: data);
}

class IntakeWorkflowScreenController
    extends BaseDashboardController<IntakeWorkflowScreenState> {
  IntakeWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: IntakeWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/intake_coordinator/workflow',
      );
}

final intake_workflowControllerProvider =
    StateNotifierProvider<
      IntakeWorkflowScreenController,
      IntakeWorkflowScreenState
    >((ref) {
      return IntakeWorkflowScreenController(ref);
    });
