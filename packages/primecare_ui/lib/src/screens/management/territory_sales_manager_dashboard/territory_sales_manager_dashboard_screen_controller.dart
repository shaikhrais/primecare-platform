import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TerritorySalesManagerDashboardScreenState
    extends DashboardState<TerritorySalesManagerDashboardScreenState> {
  TerritorySalesManagerDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TerritorySalesManagerDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TerritorySalesManagerDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TerritorySalesManagerDashboardScreenController
    extends BaseDashboardController<TerritorySalesManagerDashboardScreenState> {
  TerritorySalesManagerDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: TerritorySalesManagerDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/marketing/roles/territory_sales_manager/dashboard',
      );
}

final territory_sales_manager_dashboardControllerProvider =
    StateNotifierProvider<
      TerritorySalesManagerDashboardScreenController,
      TerritorySalesManagerDashboardScreenState
    >((ref) {
      return TerritorySalesManagerDashboardScreenController(ref);
    });
