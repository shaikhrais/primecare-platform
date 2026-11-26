import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuestWorkflowScreenState
    extends DashboardState<GuestWorkflowScreenState> {
  GuestWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  GuestWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      GuestWorkflowScreenState(isLoading: isLoading, error: error, data: data);
}

class GuestWorkflowScreenController
    extends BaseDashboardController<GuestWorkflowScreenState> {
  GuestWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: GuestWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/common/guest-workflow',
      );
}

final guest_workflowControllerProvider =
    StateNotifierProvider<
      GuestWorkflowScreenController,
      GuestWorkflowScreenState
    >((ref) {
      return GuestWorkflowScreenController(ref);
    });
