import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupportWorkflowScreenState
    extends DashboardState<SupportWorkflowScreenState> {
  SupportWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SupportWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SupportWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SupportWorkflowScreenController
    extends BaseDashboardController<SupportWorkflowScreenState> {
  SupportWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: SupportWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/common/support-workflow',
      );
}

final support_workflowControllerProvider =
    StateNotifierProvider<
      SupportWorkflowScreenController,
      SupportWorkflowScreenState
    >((ref) {
      return SupportWorkflowScreenController(ref);
    });
