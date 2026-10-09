import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtExercisePlanScreenState
    extends DashboardState<RmtExercisePlanScreenState> {
  RmtExercisePlanScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RmtExercisePlanScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RmtExercisePlanScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RmtExercisePlanScreenController
    extends BaseDashboardController<RmtExercisePlanScreenState> {
  RmtExercisePlanScreenController(Ref ref)
    : super(
        ref,
        initialState: RmtExercisePlanScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rmt/exercise-plan',
      );
}

final rmt_exercise_planControllerProvider =
    StateNotifierProvider<
      RmtExercisePlanScreenController,
      RmtExercisePlanScreenState
    >((ref) {
      return RmtExercisePlanScreenController(ref);
    });
