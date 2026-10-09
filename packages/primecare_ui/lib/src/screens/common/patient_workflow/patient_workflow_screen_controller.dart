import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientWorkflowScreenState
    extends DashboardState<PatientWorkflowScreenState> {
  PatientWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PatientWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PatientWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PatientWorkflowScreenController
    extends BaseDashboardController<PatientWorkflowScreenState> {
  PatientWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: PatientWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/common/patient-workflow',
      );
}

final patient_workflowControllerProvider =
    StateNotifierProvider<
      PatientWorkflowScreenController,
      PatientWorkflowScreenState
    >((ref) {
      return PatientWorkflowScreenController(ref);
    });
