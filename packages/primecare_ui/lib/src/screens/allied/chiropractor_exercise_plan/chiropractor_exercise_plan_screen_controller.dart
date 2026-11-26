import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorExercisePlanScreenState
    extends DashboardState<ChiropractorExercisePlanScreenState> {
  ChiropractorExercisePlanScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ChiropractorExercisePlanScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ChiropractorExercisePlanScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ChiropractorExercisePlanScreenController
    extends BaseDashboardController<ChiropractorExercisePlanScreenState> {
  ChiropractorExercisePlanScreenController(Ref ref)
    : super(
        ref,
        initialState: ChiropractorExercisePlanScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/chiropractor/exercise-plan',
      );
}

final chiropractor_exercise_planControllerProvider =
    StateNotifierProvider<
      ChiropractorExercisePlanScreenController,
      ChiropractorExercisePlanScreenState
    >((ref) {
      return ChiropractorExercisePlanScreenController(ref);
    });
