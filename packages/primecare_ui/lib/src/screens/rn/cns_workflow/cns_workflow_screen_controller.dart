import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalNurseSpecialistComplianceWorkflowScreenState
    extends
        DashboardState<ClinicalNurseSpecialistComplianceWorkflowScreenState> {
  ClinicalNurseSpecialistComplianceWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClinicalNurseSpecialistComplianceWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClinicalNurseSpecialistComplianceWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ClinicalNurseSpecialistComplianceWorkflowScreenController
    extends
        BaseDashboardController<
          ClinicalNurseSpecialistComplianceWorkflowScreenState
        > {
  ClinicalNurseSpecialistComplianceWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: ClinicalNurseSpecialistComplianceWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/rn/cns-workflow',
      );
}

final cns_workflowControllerProvider =
    StateNotifierProvider<
      ClinicalNurseSpecialistComplianceWorkflowScreenController,
      ClinicalNurseSpecialistComplianceWorkflowScreenState
    >((ref) {
      return ClinicalNurseSpecialistComplianceWorkflowScreenController(ref);
    });
