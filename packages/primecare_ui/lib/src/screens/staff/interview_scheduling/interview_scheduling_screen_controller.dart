import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InterviewSchedulingScreenState
    extends DashboardState<InterviewSchedulingScreenState> {
  InterviewSchedulingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  InterviewSchedulingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => InterviewSchedulingScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class InterviewSchedulingScreenController
    extends BaseDashboardController<InterviewSchedulingScreenState> {
  InterviewSchedulingScreenController(Ref ref)
    : super(
        ref,
        initialState: InterviewSchedulingScreenState(isLoading: true, data: {}),
        endpoint: '/staff/interview-scheduling',
      );
}

final interview_schedulingControllerProvider =
    StateNotifierProvider<
      InterviewSchedulingScreenController,
      InterviewSchedulingScreenState
    >((ref) {
      return InterviewSchedulingScreenController(ref);
    });
