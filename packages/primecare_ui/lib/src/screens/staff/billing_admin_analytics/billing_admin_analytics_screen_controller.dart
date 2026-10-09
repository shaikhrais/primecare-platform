import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillingAdminAnalyticsScreenState
    extends DashboardState<BillingAdminAnalyticsScreenState> {
  BillingAdminAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  BillingAdminAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => BillingAdminAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class BillingAdminAnalyticsScreenController
    extends BaseDashboardController<BillingAdminAnalyticsScreenState> {
  BillingAdminAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: BillingAdminAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/billing-admin-analytics',
      );
}

final billing_admin_analyticsControllerProvider =
    StateNotifierProvider<
      BillingAdminAnalyticsScreenController,
      BillingAdminAnalyticsScreenState
    >((ref) {
      return BillingAdminAnalyticsScreenController(ref);
    });
