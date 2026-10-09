import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicWorkflowScreenState
    extends DashboardState<ClinicWorkflowScreenState> {
  ClinicWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClinicWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      ClinicWorkflowScreenState(isLoading: isLoading, error: error, data: data);
}

class ClinicWorkflowScreenController
    extends BaseDashboardController<ClinicWorkflowScreenState> {
  ClinicWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: ClinicWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/clinical_director/clinic-workflow',
      );
}

final clinic_workflowControllerProvider =
    StateNotifierProvider<
      ClinicWorkflowScreenController,
      ClinicWorkflowScreenState
    >((ref) {
      return ClinicWorkflowScreenController(ref);
    });
