import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OwnerWorkflowScreenState
    extends DashboardState<OwnerWorkflowScreenState> {
  OwnerWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  OwnerWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      OwnerWorkflowScreenState(isLoading: isLoading, error: error, data: data);
}

class OwnerWorkflowScreenController
    extends BaseDashboardController<OwnerWorkflowScreenState> {
  OwnerWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: OwnerWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/executive/owner-workflow',
      );
}

final owner_workflowControllerProvider =
    StateNotifierProvider<
      OwnerWorkflowScreenController,
      OwnerWorkflowScreenState
    >((ref) {
      return OwnerWorkflowScreenController(ref);
    });
