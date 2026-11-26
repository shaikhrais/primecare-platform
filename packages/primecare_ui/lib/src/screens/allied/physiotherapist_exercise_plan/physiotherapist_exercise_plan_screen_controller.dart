import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysiotherapistExercisePlanScreenState
    extends DashboardState<PhysiotherapistExercisePlanScreenState> {
  PhysiotherapistExercisePlanScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PhysiotherapistExercisePlanScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PhysiotherapistExercisePlanScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PhysiotherapistExercisePlanScreenController
    extends BaseDashboardController<PhysiotherapistExercisePlanScreenState> {
  PhysiotherapistExercisePlanScreenController(Ref ref)
    : super(
        ref,
        initialState: PhysiotherapistExercisePlanScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/physiotherapist/exercise-plan',
      );
}

final physiotherapist_exercise_planControllerProvider =
    StateNotifierProvider<
      PhysiotherapistExercisePlanScreenController,
      PhysiotherapistExercisePlanScreenState
    >((ref) {
      return PhysiotherapistExercisePlanScreenController(ref);
    });
