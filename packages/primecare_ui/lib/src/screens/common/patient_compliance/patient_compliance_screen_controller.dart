import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientComplianceScreenState
    extends DashboardState<PatientComplianceScreenState> {
  PatientComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PatientComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PatientComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PatientComplianceScreenController
    extends BaseDashboardController<PatientComplianceScreenState> {
  PatientComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: PatientComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/common/patient-compliance',
      );
}

final patient_complianceControllerProvider =
    StateNotifierProvider<
      PatientComplianceScreenController,
      PatientComplianceScreenState
    >((ref) {
      return PatientComplianceScreenController(ref);
    });
