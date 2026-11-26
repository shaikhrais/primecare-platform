import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExercisePrescriptionScreenState
    extends DashboardState<ExercisePrescriptionScreenState> {
  ExercisePrescriptionScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ExercisePrescriptionScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ExercisePrescriptionScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ExercisePrescriptionScreenController
    extends BaseDashboardController<ExercisePrescriptionScreenState> {
  ExercisePrescriptionScreenController(Ref ref)
    : super(
        ref,
        initialState: ExercisePrescriptionScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint:
            '/offices/clinical/roles/physiotherapist/exercise-prescription',
      );
}

final exercise_prescriptionControllerProvider =
    StateNotifierProvider<
      ExercisePrescriptionScreenController,
      ExercisePrescriptionScreenState
    >((ref) {
      return ExercisePrescriptionScreenController(ref);
    });
