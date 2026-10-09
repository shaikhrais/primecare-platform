import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorAssessmentQueueScreenState
    extends DashboardState<IntakeCoordinatorAssessmentQueueScreenState> {
  IntakeCoordinatorAssessmentQueueScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  IntakeCoordinatorAssessmentQueueScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorAssessmentQueueScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class IntakeCoordinatorAssessmentQueueScreenController
    extends
        BaseDashboardController<IntakeCoordinatorAssessmentQueueScreenState> {
  IntakeCoordinatorAssessmentQueueScreenController(Ref ref)
    : super(
        ref,
        initialState: IntakeCoordinatorAssessmentQueueScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/intake-coordinator-assessment-queue',
      );
}

final intake_coordinator_assessment_queueControllerProvider =
    StateNotifierProvider<
      IntakeCoordinatorAssessmentQueueScreenController,
      IntakeCoordinatorAssessmentQueueScreenState
    >((ref) {
      return IntakeCoordinatorAssessmentQueueScreenController(ref);
    });
