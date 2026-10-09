import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VolunteerCoordinatorAnalyticsScreenState
    extends DashboardState<VolunteerCoordinatorAnalyticsScreenState> {
  VolunteerCoordinatorAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  VolunteerCoordinatorAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => VolunteerCoordinatorAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class VolunteerCoordinatorAnalyticsScreenController
    extends BaseDashboardController<VolunteerCoordinatorAnalyticsScreenState> {
  VolunteerCoordinatorAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: VolunteerCoordinatorAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/volunteer-coordinator-analytics',
      );
}

final volunteer_coordinator_analyticsControllerProvider =
    StateNotifierProvider<
      VolunteerCoordinatorAnalyticsScreenController,
      VolunteerCoordinatorAnalyticsScreenState
    >((ref) {
      return VolunteerCoordinatorAnalyticsScreenController(ref);
    });
