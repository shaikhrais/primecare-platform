import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TerritorySalesManagerAnalyticsScreenState
    extends DashboardState<TerritorySalesManagerAnalyticsScreenState> {
  TerritorySalesManagerAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TerritorySalesManagerAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TerritorySalesManagerAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TerritorySalesManagerAnalyticsScreenController
    extends BaseDashboardController<TerritorySalesManagerAnalyticsScreenState> {
  TerritorySalesManagerAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: TerritorySalesManagerAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/territory-sales-manager-analytics',
      );
}

final territory_sales_manager_analyticsControllerProvider =
    StateNotifierProvider<
      TerritorySalesManagerAnalyticsScreenController,
      TerritorySalesManagerAnalyticsScreenState
    >((ref) {
      return TerritorySalesManagerAnalyticsScreenController(ref);
    });
