import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VolunteerDashboardScreenState
    extends DashboardState<VolunteerDashboardScreenState> {
  VolunteerDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  VolunteerDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => VolunteerDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class VolunteerDashboardScreenController
    extends BaseDashboardController<VolunteerDashboardScreenState> {
  VolunteerDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: VolunteerDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/staff/volunteer-dashboard',
      );
}

final volunteer_dashboardControllerProvider =
    StateNotifierProvider<
      VolunteerDashboardScreenController,
      VolunteerDashboardScreenState
    >((ref) {
      return VolunteerDashboardScreenController(ref);
    });
