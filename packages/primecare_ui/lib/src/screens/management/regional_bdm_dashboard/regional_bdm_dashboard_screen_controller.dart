import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalBdmDashboardScreenState
    extends DashboardState<RegionalBdmDashboardScreenState> {
  RegionalBdmDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RegionalBdmDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RegionalBdmDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RegionalBdmDashboardScreenController
    extends BaseDashboardController<RegionalBdmDashboardScreenState> {
  RegionalBdmDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: RegionalBdmDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/business_development/roles/regional_bdm/dashboard',
      );
}

final regional_bdm_dashboardControllerProvider =
    StateNotifierProvider<
      RegionalBdmDashboardScreenController,
      RegionalBdmDashboardScreenState
    >((ref) {
      return RegionalBdmDashboardScreenController(ref);
    });
