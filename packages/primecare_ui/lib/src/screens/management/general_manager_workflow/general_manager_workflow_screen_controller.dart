import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeneralManagerWorkflowScreenState
    extends DashboardState<GeneralManagerWorkflowScreenState> {
  GeneralManagerWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  GeneralManagerWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => GeneralManagerWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class GeneralManagerWorkflowScreenController
    extends BaseDashboardController<GeneralManagerWorkflowScreenState> {
  GeneralManagerWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: GeneralManagerWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/general-manager-workflow',
      );
}

final general_manager_workflowControllerProvider =
    StateNotifierProvider<
      GeneralManagerWorkflowScreenController,
      GeneralManagerWorkflowScreenState
    >((ref) {
      return GeneralManagerWorkflowScreenController(ref);
    });
