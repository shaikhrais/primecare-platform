import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropracticAssessmentScreenState
    extends DashboardState<ChiropracticAssessmentScreenState> {
  ChiropracticAssessmentScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ChiropracticAssessmentScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ChiropracticAssessmentScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ChiropracticAssessmentScreenController
    extends BaseDashboardController<ChiropracticAssessmentScreenState> {
  ChiropracticAssessmentScreenController(Ref ref)
    : super(
        ref,
        initialState: ChiropracticAssessmentScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint:
            '/offices/clinical/roles/chiropractor/chiropractic-assessment',
      );
}

final chiropractic_assessmentControllerProvider =
    StateNotifierProvider<
      ChiropracticAssessmentScreenController,
      ChiropracticAssessmentScreenState
    >((ref) {
      return ChiropracticAssessmentScreenController(ref);
    });
