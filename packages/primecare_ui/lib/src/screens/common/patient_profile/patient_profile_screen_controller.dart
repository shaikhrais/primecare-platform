import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientProfileScreenState
    extends DashboardState<PatientProfileScreenState> {
  PatientProfileScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PatientProfileScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      PatientProfileScreenState(isLoading: isLoading, error: error, data: data);
}

class PatientProfileScreenController
    extends BaseDashboardController<PatientProfileScreenState> {
  PatientProfileScreenController(Ref ref)
    : super(
        ref,
        initialState: PatientProfileScreenState(isLoading: true, data: {}),
        endpoint: '/offices/client/roles/client/profile',
      );
}

final patient_profileControllerProvider =
    StateNotifierProvider<
      PatientProfileScreenController,
      PatientProfileScreenState
    >((ref) {
      return PatientProfileScreenController(ref);
    });
