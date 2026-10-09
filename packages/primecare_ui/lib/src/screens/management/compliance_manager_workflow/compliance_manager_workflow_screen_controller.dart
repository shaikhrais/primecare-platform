import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceManagerWorkflowScreenState
    extends DashboardState<ComplianceManagerWorkflowScreenState> {
  ComplianceManagerWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ComplianceManagerWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ComplianceManagerWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ComplianceManagerWorkflowScreenController
    extends BaseDashboardController<ComplianceManagerWorkflowScreenState> {
  ComplianceManagerWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: ComplianceManagerWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/compliance-manager-workflow',
      );
}

final compliance_manager_workflowControllerProvider =
    StateNotifierProvider<
      ComplianceManagerWorkflowScreenController,
      ComplianceManagerWorkflowScreenState
    >((ref) {
      return ComplianceManagerWorkflowScreenController(ref);
    });
