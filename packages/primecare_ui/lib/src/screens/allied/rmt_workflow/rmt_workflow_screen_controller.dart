import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtWorkflowScreenState extends DashboardState<RmtWorkflowScreenState> {
  RmtWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RmtWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RmtWorkflowScreenState(isLoading: isLoading, error: error, data: data);
}

class RmtWorkflowScreenController
    extends BaseDashboardController<RmtWorkflowScreenState> {
  RmtWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: RmtWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rmt/workflow',
      );
}

final rmt_workflowControllerProvider =
    StateNotifierProvider<RmtWorkflowScreenController, RmtWorkflowScreenState>((
      ref,
    ) {
      return RmtWorkflowScreenController(ref);
    });
