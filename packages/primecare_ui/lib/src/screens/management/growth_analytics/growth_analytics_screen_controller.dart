import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GrowthAnalyticsScreenState
    extends DashboardState<GrowthAnalyticsScreenState> {
  GrowthAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  GrowthAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => GrowthAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class GrowthAnalyticsScreenController
    extends BaseDashboardController<GrowthAnalyticsScreenState> {
  GrowthAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: GrowthAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/management/growth-analytics',
      );
}

final growth_analyticsControllerProvider =
    StateNotifierProvider<
      GrowthAnalyticsScreenController,
      GrowthAnalyticsScreenState
    >((ref) {
      return GrowthAnalyticsScreenController(ref);
    });
