import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientCarePlanScreenState
    extends DashboardState<PatientCarePlanScreenState> {
  PatientCarePlanScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PatientCarePlanScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PatientCarePlanScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PatientCarePlanScreenController
    extends BaseDashboardController<PatientCarePlanScreenState> {
  PatientCarePlanScreenController(Ref ref)
    : super(
        ref,
        initialState: PatientCarePlanScreenState(isLoading: true, data: {}),
        endpoint: '/common/patient-care-plan',
      );
}

final patient_care_planControllerProvider =
    StateNotifierProvider<
      PatientCarePlanScreenController,
      PatientCarePlanScreenState
    >((ref) {
      return PatientCarePlanScreenController(ref);
    });
