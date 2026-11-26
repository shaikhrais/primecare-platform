import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RevenueAnalyticsScreenState
    extends DashboardState<RevenueAnalyticsScreenState> {
  RevenueAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RevenueAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RevenueAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RevenueAnalyticsScreenController
    extends BaseDashboardController<RevenueAnalyticsScreenState> {
  RevenueAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: RevenueAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/executive/revenue-analytics',
      );
}

final revenue_analyticsControllerProvider =
    StateNotifierProvider<
      RevenueAnalyticsScreenController,
      RevenueAnalyticsScreenState
    >((ref) {
      return RevenueAnalyticsScreenController(ref);
    });
