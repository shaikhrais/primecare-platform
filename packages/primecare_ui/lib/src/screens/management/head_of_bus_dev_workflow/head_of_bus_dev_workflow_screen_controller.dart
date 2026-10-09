import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadOfBusDevWorkflowScreenState
    extends DashboardState<HeadOfBusDevWorkflowScreenState> {
  HeadOfBusDevWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HeadOfBusDevWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HeadOfBusDevWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HeadOfBusDevWorkflowScreenController
    extends BaseDashboardController<HeadOfBusDevWorkflowScreenState> {
  HeadOfBusDevWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: HeadOfBusDevWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/head-of-bus-dev-workflow',
      );
}

final head_of_bus_dev_workflowControllerProvider =
    StateNotifierProvider<
      HeadOfBusDevWorkflowScreenController,
      HeadOfBusDevWorkflowScreenState
    >((ref) {
      return HeadOfBusDevWorkflowScreenController(ref);
    });
