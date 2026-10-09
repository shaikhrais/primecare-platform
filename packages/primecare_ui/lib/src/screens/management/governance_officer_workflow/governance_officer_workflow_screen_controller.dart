import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GovernanceOfficerWorkflowScreenState
    extends DashboardState<GovernanceOfficerWorkflowScreenState> {
  GovernanceOfficerWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  GovernanceOfficerWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => GovernanceOfficerWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class GovernanceOfficerWorkflowScreenController
    extends BaseDashboardController<GovernanceOfficerWorkflowScreenState> {
  GovernanceOfficerWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: GovernanceOfficerWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/governance-officer-workflow',
      );
}

final governance_officer_workflowControllerProvider =
    StateNotifierProvider<
      GovernanceOfficerWorkflowScreenController,
      GovernanceOfficerWorkflowScreenState
    >((ref) {
      return GovernanceOfficerWorkflowScreenController(ref);
    });
