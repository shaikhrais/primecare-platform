import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TerritoryExpansionManagerDashboardScreenState
    extends DashboardState<TerritoryExpansionManagerDashboardScreenState> {
  TerritoryExpansionManagerDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TerritoryExpansionManagerDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TerritoryExpansionManagerDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TerritoryExpansionManagerDashboardScreenController
    extends
        BaseDashboardController<TerritoryExpansionManagerDashboardScreenState> {
  TerritoryExpansionManagerDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: TerritoryExpansionManagerDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint:
            '/offices/business_development/roles/territory_expansion_manager/dashboard',
      );
}

final territory_expansion_manager_dashboardControllerProvider =
    StateNotifierProvider<
      TerritoryExpansionManagerDashboardScreenController,
      TerritoryExpansionManagerDashboardScreenState
    >((ref) {
      return TerritoryExpansionManagerDashboardScreenController(ref);
    });
