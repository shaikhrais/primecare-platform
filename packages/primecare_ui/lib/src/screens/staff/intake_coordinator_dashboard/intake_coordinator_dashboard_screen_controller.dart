import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorDashboardScreenState
    extends DashboardState<IntakeCoordinatorDashboardScreenState> {
  IntakeCoordinatorDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  IntakeCoordinatorDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class IntakeCoordinatorDashboardScreenController
    extends BaseDashboardController<IntakeCoordinatorDashboardScreenState> {
  IntakeCoordinatorDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: IntakeCoordinatorDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/intake_coordinator/dashboard',
      );
}

final intake_coordinator_dashboardControllerProvider =
    StateNotifierProvider<
      IntakeCoordinatorDashboardScreenController,
      IntakeCoordinatorDashboardScreenState
    >((ref) {
      return IntakeCoordinatorDashboardScreenController(ref);
    });
