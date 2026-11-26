import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalWorkflowScreenState
    extends DashboardState<ClinicalWorkflowScreenState> {
  ClinicalWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClinicalWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClinicalWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ClinicalWorkflowScreenController
    extends BaseDashboardController<ClinicalWorkflowScreenState> {
  ClinicalWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: ClinicalWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/clinical_director/workflow',
      );
}

final clinical_workflowControllerProvider =
    StateNotifierProvider<
      ClinicalWorkflowScreenController,
      ClinicalWorkflowScreenState
    >((ref) {
      return ClinicalWorkflowScreenController(ref);
    });
