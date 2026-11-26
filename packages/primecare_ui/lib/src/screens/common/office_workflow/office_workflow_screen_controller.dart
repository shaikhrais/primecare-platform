import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfficeWorkflowScreenState
    extends DashboardState<OfficeWorkflowScreenState> {
  OfficeWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  OfficeWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      OfficeWorkflowScreenState(isLoading: isLoading, error: error, data: data);
}

class OfficeWorkflowScreenController
    extends BaseDashboardController<OfficeWorkflowScreenState> {
  OfficeWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: OfficeWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/common/office-workflow',
      );
}

final office_workflowControllerProvider =
    StateNotifierProvider<
      OfficeWorkflowScreenController,
      OfficeWorkflowScreenState
    >((ref) {
      return OfficeWorkflowScreenController(ref);
    });
