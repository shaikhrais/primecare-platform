import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoWorkflowScreenState extends DashboardState<CfoWorkflowScreenState> {
  CfoWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CfoWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CfoWorkflowScreenState(isLoading: isLoading, error: error, data: data);
}

class CfoWorkflowScreenController
    extends BaseDashboardController<CfoWorkflowScreenState> {
  CfoWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: CfoWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/executive/cfo-workflow',
      );
}

final cfo_workflowControllerProvider =
    StateNotifierProvider<CfoWorkflowScreenController, CfoWorkflowScreenState>((
      ref,
    ) {
      return CfoWorkflowScreenController(ref);
    });
