import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillingAdminComplianceScreenState
    extends DashboardState<BillingAdminComplianceScreenState> {
  BillingAdminComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  BillingAdminComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => BillingAdminComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class BillingAdminComplianceScreenController
    extends BaseDashboardController<BillingAdminComplianceScreenState> {
  BillingAdminComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: BillingAdminComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/billing-admin-compliance',
      );
}

final billing_admin_complianceControllerProvider =
    StateNotifierProvider<
      BillingAdminComplianceScreenController,
      BillingAdminComplianceScreenState
    >((ref) {
      return BillingAdminComplianceScreenController(ref);
    });
