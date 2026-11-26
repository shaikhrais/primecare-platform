import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseSalesManagerWorkflowScreenState
    extends DashboardState<FranchiseSalesManagerWorkflowScreenState> {
  FranchiseSalesManagerWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseSalesManagerWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseSalesManagerWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseSalesManagerWorkflowScreenController
    extends BaseDashboardController<FranchiseSalesManagerWorkflowScreenState> {
  FranchiseSalesManagerWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseSalesManagerWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/franchise-sales-manager-workflow',
      );
}

final franchise_sales_manager_workflowControllerProvider =
    StateNotifierProvider<
      FranchiseSalesManagerWorkflowScreenController,
      FranchiseSalesManagerWorkflowScreenState
    >((ref) {
      return FranchiseSalesManagerWorkflowScreenController(ref);
    });
