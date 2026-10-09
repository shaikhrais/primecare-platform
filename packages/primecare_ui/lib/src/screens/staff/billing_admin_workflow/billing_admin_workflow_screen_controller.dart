import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillingAdminWorkflowScreenState
    extends DashboardState<BillingAdminWorkflowScreenState> {
  BillingAdminWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  BillingAdminWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => BillingAdminWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class BillingAdminWorkflowScreenController
    extends BaseDashboardController<BillingAdminWorkflowScreenState> {
  BillingAdminWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: BillingAdminWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/billing-admin-workflow',
      );
}

final billing_admin_workflowControllerProvider =
    StateNotifierProvider<
      BillingAdminWorkflowScreenController,
      BillingAdminWorkflowScreenState
    >((ref) {
      return BillingAdminWorkflowScreenController(ref);
    });
