import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoleCoverageDashboardScreenState
    extends DashboardState<RoleCoverageDashboardScreenState> {
  RoleCoverageDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RoleCoverageDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RoleCoverageDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RoleCoverageDashboardScreenController
    extends BaseDashboardController<RoleCoverageDashboardScreenState> {
  RoleCoverageDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: RoleCoverageDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/role-coverage-dashboard',
      );
}

final role_coverage_dashboardControllerProvider =
    StateNotifierProvider<
      RoleCoverageDashboardScreenController,
      RoleCoverageDashboardScreenState
    >((ref) {
      return RoleCoverageDashboardScreenController(ref);
    });
