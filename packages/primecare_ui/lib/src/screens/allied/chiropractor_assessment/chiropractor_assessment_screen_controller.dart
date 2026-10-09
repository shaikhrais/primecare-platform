import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorAssessmentScreenState
    extends DashboardState<ChiropractorAssessmentScreenState> {
  ChiropractorAssessmentScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ChiropractorAssessmentScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ChiropractorAssessmentScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ChiropractorAssessmentScreenController
    extends BaseDashboardController<ChiropractorAssessmentScreenState> {
  ChiropractorAssessmentScreenController(Ref ref)
    : super(
        ref,
        initialState: ChiropractorAssessmentScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/chiropractor/assessment',
      );
}

final chiropractor_assessmentControllerProvider =
    StateNotifierProvider<
      ChiropractorAssessmentScreenController,
      ChiropractorAssessmentScreenState
    >((ref) {
      return ChiropractorAssessmentScreenController(ref);
    });
