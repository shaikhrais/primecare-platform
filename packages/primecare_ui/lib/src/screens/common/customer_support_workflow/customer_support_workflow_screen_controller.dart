import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerSupportWorkflowScreenState
    extends DashboardState<CustomerSupportWorkflowScreenState> {
  CustomerSupportWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CustomerSupportWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CustomerSupportWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CustomerSupportWorkflowScreenController
    extends BaseDashboardController<CustomerSupportWorkflowScreenState> {
  CustomerSupportWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: CustomerSupportWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/customer-support-workflow',
      );
}

final customer_support_workflowControllerProvider =
    StateNotifierProvider<
      CustomerSupportWorkflowScreenController,
      CustomerSupportWorkflowScreenState
    >((ref) {
      return CustomerSupportWorkflowScreenController(ref);
    });
