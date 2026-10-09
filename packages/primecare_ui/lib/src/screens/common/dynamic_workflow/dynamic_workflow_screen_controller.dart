import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicScreenWorkflowScreenState
    extends DashboardState<DynamicScreenWorkflowScreenState> {
  DynamicScreenWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  DynamicScreenWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => DynamicScreenWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class DynamicScreenWorkflowScreenController
    extends BaseDashboardController<DynamicScreenWorkflowScreenState> {
  DynamicScreenWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: DynamicScreenWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/dynamic-workflow',
      );
}

final dynamic_workflowControllerProvider =
    StateNotifierProvider<
      DynamicScreenWorkflowScreenController,
      DynamicScreenWorkflowScreenState
    >((ref) {
      return DynamicScreenWorkflowScreenController(ref);
    });
