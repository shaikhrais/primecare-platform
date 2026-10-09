import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillingOverviewScreenState
    extends DashboardState<BillingOverviewScreenState> {
  BillingOverviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  BillingOverviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => BillingOverviewScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class BillingOverviewScreenController
    extends BaseDashboardController<BillingOverviewScreenState> {
  BillingOverviewScreenController(Ref ref)
    : super(
        ref,
        initialState: BillingOverviewScreenState(isLoading: true, data: {}),
        endpoint: '/common/billing-overview',
      );
}

final billing_overviewControllerProvider =
    StateNotifierProvider<
      BillingOverviewScreenController,
      BillingOverviewScreenState
    >((ref) {
      return BillingOverviewScreenController(ref);
    });
