import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientCommandCenterScreenState
    extends DashboardState<PatientCommandCenterScreenState> {
  PatientCommandCenterScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PatientCommandCenterScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PatientCommandCenterScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PatientCommandCenterScreenController
    extends BaseDashboardController<PatientCommandCenterScreenState> {
  PatientCommandCenterScreenController(Ref ref)
    : super(
        ref,
        initialState: PatientCommandCenterScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/patient-command-center',
      );
}

final patient_command_centerControllerProvider =
    StateNotifierProvider<
      PatientCommandCenterScreenController,
      PatientCommandCenterScreenState
    >((ref) {
      return PatientCommandCenterScreenController(ref);
    });
