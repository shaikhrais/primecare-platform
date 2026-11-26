import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseSalesManagerAnalyticsScreenState
    extends DashboardState<FranchiseSalesManagerAnalyticsScreenState> {
  FranchiseSalesManagerAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseSalesManagerAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseSalesManagerAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseSalesManagerAnalyticsScreenController
    extends BaseDashboardController<FranchiseSalesManagerAnalyticsScreenState> {
  FranchiseSalesManagerAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseSalesManagerAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/franchise-sales-analytics',
      );
}

final franchise_sales_analyticsControllerProvider =
    StateNotifierProvider<
      FranchiseSalesManagerAnalyticsScreenController,
      FranchiseSalesManagerAnalyticsScreenState
    >((ref) {
      return FranchiseSalesManagerAnalyticsScreenController(ref);
    });
