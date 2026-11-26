import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysicianComplianceWorkflowScreenState
    extends DashboardState<PhysicianComplianceWorkflowScreenState> {
  PhysicianComplianceWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PhysicianComplianceWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PhysicianComplianceWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PhysicianComplianceWorkflowScreenController
    extends BaseDashboardController<PhysicianComplianceWorkflowScreenState> {
  PhysicianComplianceWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: PhysicianComplianceWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/clinical/physician-workflow',
      );
}

final physician_workflowControllerProvider =
    StateNotifierProvider<
      PhysicianComplianceWorkflowScreenController,
      PhysicianComplianceWorkflowScreenState
    >((ref) {
      return PhysicianComplianceWorkflowScreenController(ref);
    });
