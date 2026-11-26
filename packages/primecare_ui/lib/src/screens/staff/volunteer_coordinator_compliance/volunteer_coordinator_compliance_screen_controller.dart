import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VolunteerCoordinatorComplianceScreenState
    extends DashboardState<VolunteerCoordinatorComplianceScreenState> {
  VolunteerCoordinatorComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  VolunteerCoordinatorComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => VolunteerCoordinatorComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class VolunteerCoordinatorComplianceScreenController
    extends BaseDashboardController<VolunteerCoordinatorComplianceScreenState> {
  VolunteerCoordinatorComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: VolunteerCoordinatorComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/volunteer-coordinator-compliance',
      );
}

final volunteer_coordinator_complianceControllerProvider =
    StateNotifierProvider<
      VolunteerCoordinatorComplianceScreenController,
      VolunteerCoordinatorComplianceScreenState
    >((ref) {
      return VolunteerCoordinatorComplianceScreenController(ref);
    });
