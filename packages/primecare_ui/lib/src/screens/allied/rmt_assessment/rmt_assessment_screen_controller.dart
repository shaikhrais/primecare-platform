import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtAssessmentScreenState
    extends DashboardState<RmtAssessmentScreenState> {
  RmtAssessmentScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RmtAssessmentScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      RmtAssessmentScreenState(isLoading: isLoading, error: error, data: data);
}

class RmtAssessmentScreenController
    extends BaseDashboardController<RmtAssessmentScreenState> {
  RmtAssessmentScreenController(Ref ref)
    : super(
        ref,
        initialState: RmtAssessmentScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rmt/assessment',
      );
}

final rmt_assessmentControllerProvider =
    StateNotifierProvider<
      RmtAssessmentScreenController,
      RmtAssessmentScreenState
    >((ref) {
      return RmtAssessmentScreenController(ref);
    });
