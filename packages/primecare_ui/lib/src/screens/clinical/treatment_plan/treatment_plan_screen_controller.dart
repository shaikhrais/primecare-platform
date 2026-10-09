import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TreatmentPlanScreenState
    extends DashboardState<TreatmentPlanScreenState> {
  TreatmentPlanScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TreatmentPlanScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      TreatmentPlanScreenState(isLoading: isLoading, error: error, data: data);
}

class TreatmentPlanScreenController
    extends BaseDashboardController<TreatmentPlanScreenState> {
  TreatmentPlanScreenController(Ref ref)
    : super(
        ref,
        initialState: TreatmentPlanScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/physiotherapist/treatment-plan',
      );
}

final treatment_planControllerProvider =
    StateNotifierProvider<
      TreatmentPlanScreenController,
      TreatmentPlanScreenState
    >((ref) {
      return TreatmentPlanScreenController(ref);
    });
