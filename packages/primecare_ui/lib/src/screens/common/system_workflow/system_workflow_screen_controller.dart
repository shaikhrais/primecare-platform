import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SystemWorkflowScreenState
    extends DashboardState<SystemWorkflowScreenState> {
  SystemWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SystemWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      SystemWorkflowScreenState(isLoading: isLoading, error: error, data: data);
}

class SystemWorkflowScreenController
    extends BaseDashboardController<SystemWorkflowScreenState> {
  SystemWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: SystemWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/common/system-workflow',
      );
}

final system_workflowControllerProvider =
    StateNotifierProvider<
      SystemWorkflowScreenController,
      SystemWorkflowScreenState
    >((ref) {
      return SystemWorkflowScreenController(ref);
    });
