import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TerritoryExpansionManagerAnalyticsScreenState
    extends DashboardState<TerritoryExpansionManagerAnalyticsScreenState> {
  TerritoryExpansionManagerAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TerritoryExpansionManagerAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TerritoryExpansionManagerAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TerritoryExpansionManagerAnalyticsScreenController
    extends
        BaseDashboardController<TerritoryExpansionManagerAnalyticsScreenState> {
  TerritoryExpansionManagerAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: TerritoryExpansionManagerAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/territory-expansion-manager-analytics',
      );
}

final territory_expansion_manager_analyticsControllerProvider =
    StateNotifierProvider<
      TerritoryExpansionManagerAnalyticsScreenController,
      TerritoryExpansionManagerAnalyticsScreenState
    >((ref) {
      return TerritoryExpansionManagerAnalyticsScreenController(ref);
    });
