import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswWorkflowScreenState extends DashboardState<PswWorkflowScreenState> {
  PswWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PswWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PswWorkflowScreenState(isLoading: isLoading, error: error, data: data);
}

class PswWorkflowScreenController
    extends BaseDashboardController<PswWorkflowScreenState> {
  PswWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: PswWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/psw/psw-workflow',
      );
}

final psw_workflowControllerProvider =
    StateNotifierProvider<PswWorkflowScreenController, PswWorkflowScreenState>((
      ref,
    ) {
      return PswWorkflowScreenController(ref);
    });
