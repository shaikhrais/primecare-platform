import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PremiumConciergeCareCoordinatorComplianceWorkflowScreenState
    extends
        DashboardState<
          PremiumConciergeCareCoordinatorComplianceWorkflowScreenState
        > {
  PremiumConciergeCareCoordinatorComplianceWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PremiumConciergeCareCoordinatorComplianceWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PremiumConciergeCareCoordinatorComplianceWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PremiumConciergeCareCoordinatorComplianceWorkflowScreenController
    extends
        BaseDashboardController<
          PremiumConciergeCareCoordinatorComplianceWorkflowScreenState
        > {
  PremiumConciergeCareCoordinatorComplianceWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState:
            PremiumConciergeCareCoordinatorComplianceWorkflowScreenState(
              isLoading: true,
              data: {},
            ),
        endpoint: '/premium/premium-concierge-workflow',
      );
}

final premium_concierge_workflowControllerProvider =
    StateNotifierProvider<
      PremiumConciergeCareCoordinatorComplianceWorkflowScreenController,
      PremiumConciergeCareCoordinatorComplianceWorkflowScreenState
    >((ref) {
      return PremiumConciergeCareCoordinatorComplianceWorkflowScreenController(
        ref,
      );
    });
