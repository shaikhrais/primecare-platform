import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VolunteerCoordinatorDashboardScreenState
    extends DashboardState<VolunteerCoordinatorDashboardScreenState> {
  VolunteerCoordinatorDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  VolunteerCoordinatorDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => VolunteerCoordinatorDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class VolunteerCoordinatorDashboardScreenController
    extends BaseDashboardController<VolunteerCoordinatorDashboardScreenState> {
  VolunteerCoordinatorDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: VolunteerCoordinatorDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/corporate/roles/volunteer_coordinator/dashboard',
      );
}

final volunteer_coordinator_dashboardControllerProvider =
    StateNotifierProvider<
      VolunteerCoordinatorDashboardScreenController,
      VolunteerCoordinatorDashboardScreenState
    >((ref) {
      return VolunteerCoordinatorDashboardScreenController(ref);
    });
