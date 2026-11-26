import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorFollowUpScreenState
    extends DashboardState<IntakeCoordinatorFollowUpScreenState> {
  IntakeCoordinatorFollowUpScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  IntakeCoordinatorFollowUpScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorFollowUpScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class IntakeCoordinatorFollowUpScreenController
    extends BaseDashboardController<IntakeCoordinatorFollowUpScreenState> {
  IntakeCoordinatorFollowUpScreenController(Ref ref)
    : super(
        ref,
        initialState: IntakeCoordinatorFollowUpScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/intake-coordinator-follow-up',
      );
}

final intake_coordinator_follow_upControllerProvider =
    StateNotifierProvider<
      IntakeCoordinatorFollowUpScreenController,
      IntakeCoordinatorFollowUpScreenState
    >((ref) {
      return IntakeCoordinatorFollowUpScreenController(ref);
    });
