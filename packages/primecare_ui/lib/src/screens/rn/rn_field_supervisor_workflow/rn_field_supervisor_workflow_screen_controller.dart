import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenState
    extends
        DashboardState<
          RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenState
        > {
  RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenController
    extends
        BaseDashboardController<
          RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenState
        > {
  RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState:
            RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenState(
              isLoading: true,
              data: {},
            ),
        endpoint: '/rn/rn-field-supervisor-workflow',
      );
}

final rn_field_supervisor_workflowControllerProvider =
    StateNotifierProvider<
      RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenController,
      RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenState
    >((ref) {
      return RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenController(
        ref,
      );
    });
