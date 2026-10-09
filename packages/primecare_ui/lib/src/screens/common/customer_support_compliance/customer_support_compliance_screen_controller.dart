import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerSupportComplianceScreenState
    extends DashboardState<CustomerSupportComplianceScreenState> {
  CustomerSupportComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CustomerSupportComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CustomerSupportComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CustomerSupportComplianceScreenController
    extends BaseDashboardController<CustomerSupportComplianceScreenState> {
  CustomerSupportComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: CustomerSupportComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/customer-support-compliance',
      );
}

final customer_support_complianceControllerProvider =
    StateNotifierProvider<
      CustomerSupportComplianceScreenController,
      CustomerSupportComplianceScreenState
    >((ref) {
      return CustomerSupportComplianceScreenController(ref);
    });
