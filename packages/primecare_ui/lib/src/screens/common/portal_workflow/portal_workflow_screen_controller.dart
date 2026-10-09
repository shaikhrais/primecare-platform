import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PortalWorkflowScreenState
    extends DashboardState<PortalWorkflowScreenState> {
  PortalWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PortalWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      PortalWorkflowScreenState(isLoading: isLoading, error: error, data: data);
}

class PortalWorkflowScreenController
    extends BaseDashboardController<PortalWorkflowScreenState> {
  PortalWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: PortalWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/common/portal-workflow',
      );
}

final portal_workflowControllerProvider =
    StateNotifierProvider<
      PortalWorkflowScreenController,
      PortalWorkflowScreenState
    >((ref) {
      return PortalWorkflowScreenController(ref);
    });
