import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkflowIssueScreenState
    extends DashboardState<WorkflowIssueScreenState> {
  WorkflowIssueScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  WorkflowIssueScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      WorkflowIssueScreenState(isLoading: isLoading, error: error, data: data);
}

class WorkflowIssueScreenController
    extends BaseDashboardController<WorkflowIssueScreenState> {
  WorkflowIssueScreenController(Ref ref)
    : super(
        ref,
        initialState: WorkflowIssueScreenState(isLoading: true, data: {}),
        endpoint: '/executive/workflow-issue',
      );
}

final workflow_issueControllerProvider =
    StateNotifierProvider<
      WorkflowIssueScreenController,
      WorkflowIssueScreenState
    >((ref) {
      return WorkflowIssueScreenController(ref);
    });
