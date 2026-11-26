import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QaWorkflowScreenState extends DashboardState<QaWorkflowScreenState> {
  QaWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  QaWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => QaWorkflowScreenState(isLoading: isLoading, error: error, data: data);
}

class QaWorkflowScreenController
    extends BaseDashboardController<QaWorkflowScreenState> {
  QaWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: QaWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/common/qa-workflow',
      );
}

final qa_workflowControllerProvider =
    StateNotifierProvider<QaWorkflowScreenController, QaWorkflowScreenState>((
      ref,
    ) {
      return QaWorkflowScreenController(ref);
    });
