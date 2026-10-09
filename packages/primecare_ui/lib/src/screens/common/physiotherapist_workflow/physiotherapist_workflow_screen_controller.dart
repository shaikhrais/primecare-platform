import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysiotherapistWorkflowScreenState
    extends DashboardState<PhysiotherapistWorkflowScreenState> {
  PhysiotherapistWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PhysiotherapistWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PhysiotherapistWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PhysiotherapistWorkflowScreenController
    extends BaseDashboardController<PhysiotherapistWorkflowScreenState> {
  PhysiotherapistWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: PhysiotherapistWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/physiotherapist/workflow',
      );
}

final physiotherapist_workflowControllerProvider =
    StateNotifierProvider<
      PhysiotherapistWorkflowScreenController,
      PhysiotherapistWorkflowScreenState
    >((ref) {
      return PhysiotherapistWorkflowScreenController(ref);
    });
