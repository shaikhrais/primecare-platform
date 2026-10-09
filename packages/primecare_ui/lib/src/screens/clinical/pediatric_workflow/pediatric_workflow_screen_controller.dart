import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PediatricSpecialistComplianceWorkflowScreenState
    extends DashboardState<PediatricSpecialistComplianceWorkflowScreenState> {
  PediatricSpecialistComplianceWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PediatricSpecialistComplianceWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PediatricSpecialistComplianceWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PediatricSpecialistComplianceWorkflowScreenController
    extends
        BaseDashboardController<
          PediatricSpecialistComplianceWorkflowScreenState
        > {
  PediatricSpecialistComplianceWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: PediatricSpecialistComplianceWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/clinical/pediatric-workflow',
      );
}

final pediatric_workflowControllerProvider =
    StateNotifierProvider<
      PediatricSpecialistComplianceWorkflowScreenController,
      PediatricSpecialistComplianceWorkflowScreenState
    >((ref) {
      return PediatricSpecialistComplianceWorkflowScreenController(ref);
    });
