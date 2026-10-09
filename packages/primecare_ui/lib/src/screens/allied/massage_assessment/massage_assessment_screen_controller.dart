import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MassageAssessmentScreenState
    extends DashboardState<MassageAssessmentScreenState> {
  MassageAssessmentScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  MassageAssessmentScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => MassageAssessmentScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class MassageAssessmentScreenController
    extends BaseDashboardController<MassageAssessmentScreenState> {
  MassageAssessmentScreenController(Ref ref)
    : super(
        ref,
        initialState: MassageAssessmentScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rmt/massage-assessment',
      );
}

final massage_assessmentControllerProvider =
    StateNotifierProvider<
      MassageAssessmentScreenController,
      MassageAssessmentScreenState
    >((ref) {
      return MassageAssessmentScreenController(ref);
    });
