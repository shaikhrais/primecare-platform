import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseSalesManagerComplianceWorkflowScreenState
    extends DashboardState<FranchiseSalesManagerComplianceWorkflowScreenState> {
  FranchiseSalesManagerComplianceWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseSalesManagerComplianceWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseSalesManagerComplianceWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseSalesManagerComplianceWorkflowScreenController
    extends
        BaseDashboardController<
          FranchiseSalesManagerComplianceWorkflowScreenState
        > {
  FranchiseSalesManagerComplianceWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseSalesManagerComplianceWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/franchise-sales-workflow',
      );
}

final franchise_sales_workflowControllerProvider =
    StateNotifierProvider<
      FranchiseSalesManagerComplianceWorkflowScreenController,
      FranchiseSalesManagerComplianceWorkflowScreenState
    >((ref) {
      return FranchiseSalesManagerComplianceWorkflowScreenController(ref);
    });
