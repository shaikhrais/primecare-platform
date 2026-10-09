import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorAnalyticsScreenState
    extends DashboardState<IntakeCoordinatorAnalyticsScreenState> {
  IntakeCoordinatorAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  IntakeCoordinatorAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class IntakeCoordinatorAnalyticsScreenController
    extends BaseDashboardController<IntakeCoordinatorAnalyticsScreenState> {
  IntakeCoordinatorAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: IntakeCoordinatorAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint:
            '/offices/clinical/roles/intake_coordinator/coordinator-analytics',
      );
}

final intake_coordinator_analyticsControllerProvider =
    StateNotifierProvider<
      IntakeCoordinatorAnalyticsScreenController,
      IntakeCoordinatorAnalyticsScreenState
    >((ref) {
      return IntakeCoordinatorAnalyticsScreenController(ref);
    });
