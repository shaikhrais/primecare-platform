import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeComplianceWorkflowScreenState
    extends DashboardState<EmployeeComplianceWorkflowScreenState> {
  EmployeeComplianceWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  EmployeeComplianceWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => EmployeeComplianceWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class EmployeeComplianceWorkflowScreenController
    extends BaseDashboardController<EmployeeComplianceWorkflowScreenState> {
  EmployeeComplianceWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: EmployeeComplianceWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/employee-workflow',
      );
}

final employee_workflowControllerProvider =
    StateNotifierProvider<
      EmployeeComplianceWorkflowScreenController,
      EmployeeComplianceWorkflowScreenState
    >((ref) {
      return EmployeeComplianceWorkflowScreenController(ref);
    });
