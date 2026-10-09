import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientAppointmentsScreenState
    extends DashboardState<PatientAppointmentsScreenState> {
  PatientAppointmentsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PatientAppointmentsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PatientAppointmentsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PatientAppointmentsScreenController
    extends BaseDashboardController<PatientAppointmentsScreenState> {
  PatientAppointmentsScreenController(Ref ref)
    : super(
        ref,
        initialState: PatientAppointmentsScreenState(isLoading: true, data: {}),
        endpoint: '/common/patient-appointments',
      );
}

final patient_appointmentsControllerProvider =
    StateNotifierProvider<
      PatientAppointmentsScreenController,
      PatientAppointmentsScreenState
    >((ref) {
      return PatientAppointmentsScreenController(ref);
    });
