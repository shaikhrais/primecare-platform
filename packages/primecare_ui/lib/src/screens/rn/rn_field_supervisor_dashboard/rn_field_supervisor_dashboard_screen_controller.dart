import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnFieldSupervisorDashboardScreenState
    extends DashboardState<RnFieldSupervisorDashboardScreenState> {
  RnFieldSupervisorDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RnFieldSupervisorDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RnFieldSupervisorDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RnFieldSupervisorDashboardScreenController
    extends BaseDashboardController<RnFieldSupervisorDashboardScreenState> {
  RnFieldSupervisorDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: RnFieldSupervisorDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/rn/rn-field-supervisor-dashboard',
      );
}

final rn_field_supervisor_dashboardControllerProvider =
    StateNotifierProvider<
      RnFieldSupervisorDashboardScreenController,
      RnFieldSupervisorDashboardScreenState
    >((ref) {
      return RnFieldSupervisorDashboardScreenController(ref);
    });
