import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CxDirectorWorkflowScreenState
    extends DashboardState<CxDirectorWorkflowScreenState> {
  CxDirectorWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CxDirectorWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CxDirectorWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CxDirectorWorkflowScreenController
    extends BaseDashboardController<CxDirectorWorkflowScreenState> {
  CxDirectorWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: CxDirectorWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/executive/cx-director-workflow',
      );
}

final cx_director_workflowControllerProvider =
    StateNotifierProvider<
      CxDirectorWorkflowScreenController,
      CxDirectorWorkflowScreenState
    >((ref) {
      return CxDirectorWorkflowScreenController(ref);
    });
