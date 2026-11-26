import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooWorkflowIssuesScreenState
    extends DashboardState<CooWorkflowIssuesScreenState> {
  CooWorkflowIssuesScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CooWorkflowIssuesScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CooWorkflowIssuesScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CooWorkflowIssuesScreenController
    extends BaseDashboardController<CooWorkflowIssuesScreenState> {
  CooWorkflowIssuesScreenController(Ref ref)
    : super(
        ref,
        initialState: CooWorkflowIssuesScreenState(isLoading: true, data: {}),
        endpoint: '/executive/coo-workflow-issues',
      );
}

final coo_workflow_issuesControllerProvider =
    StateNotifierProvider<
      CooWorkflowIssuesScreenController,
      CooWorkflowIssuesScreenState
    >((ref) {
      return CooWorkflowIssuesScreenController(ref);
    });
