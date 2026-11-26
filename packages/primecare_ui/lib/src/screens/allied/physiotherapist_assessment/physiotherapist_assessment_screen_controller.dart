import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysiotherapistAssessmentScreenState
    extends DashboardState<PhysiotherapistAssessmentScreenState> {
  PhysiotherapistAssessmentScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PhysiotherapistAssessmentScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PhysiotherapistAssessmentScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PhysiotherapistAssessmentScreenController
    extends BaseDashboardController<PhysiotherapistAssessmentScreenState> {
  PhysiotherapistAssessmentScreenController(Ref ref)
    : super(
        ref,
        initialState: PhysiotherapistAssessmentScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/physiotherapist/assessment',
      );
}

final physiotherapist_assessmentControllerProvider =
    StateNotifierProvider<
      PhysiotherapistAssessmentScreenController,
      PhysiotherapistAssessmentScreenState
    >((ref) {
      return PhysiotherapistAssessmentScreenController(ref);
    });
