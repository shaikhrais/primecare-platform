import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientObservationScreenState
    extends DashboardState<PatientObservationScreenState> {
  PatientObservationScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PatientObservationScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PatientObservationScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PatientObservationScreenController
    extends BaseDashboardController<PatientObservationScreenState> {
  PatientObservationScreenController(Ref ref)
    : super(
        ref,
        initialState: PatientObservationScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rpn/patient-observation',
      );
}

final patient_observationControllerProvider =
    StateNotifierProvider<
      PatientObservationScreenController,
      PatientObservationScreenState
    >((ref) {
      return PatientObservationScreenController(ref);
    });
