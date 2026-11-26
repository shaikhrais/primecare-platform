import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerSupportAnalyticsScreenState
    extends DashboardState<CustomerSupportAnalyticsScreenState> {
  CustomerSupportAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CustomerSupportAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CustomerSupportAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CustomerSupportAnalyticsScreenController
    extends BaseDashboardController<CustomerSupportAnalyticsScreenState> {
  CustomerSupportAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: CustomerSupportAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/customer-support-analytics',
      );
}

final customer_support_analyticsControllerProvider =
    StateNotifierProvider<
      CustomerSupportAnalyticsScreenController,
      CustomerSupportAnalyticsScreenState
    >((ref) {
      return CustomerSupportAnalyticsScreenController(ref);
    });
