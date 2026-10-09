import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistComplianceWorkflowScreenState
    extends DashboardState<TherapistComplianceWorkflowScreenState> {
  TherapistComplianceWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TherapistComplianceWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TherapistComplianceWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TherapistComplianceWorkflowScreenController
    extends BaseDashboardController<TherapistComplianceWorkflowScreenState> {
  TherapistComplianceWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: TherapistComplianceWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/therapist/workflow',
      );
}

final therapist_workflowControllerProvider =
    StateNotifierProvider<
      TherapistComplianceWorkflowScreenController,
      TherapistComplianceWorkflowScreenState
    >((ref) {
      return TherapistComplianceWorkflowScreenController(ref);
    });
