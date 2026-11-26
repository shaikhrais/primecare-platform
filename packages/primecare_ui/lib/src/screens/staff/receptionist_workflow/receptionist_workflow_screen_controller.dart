import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReceptionistWorkflowScreenState
    extends DashboardState<ReceptionistWorkflowScreenState> {
  ReceptionistWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ReceptionistWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ReceptionistWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ReceptionistWorkflowScreenController
    extends BaseDashboardController<ReceptionistWorkflowScreenState> {
  ReceptionistWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: ReceptionistWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/receptionist-workflow',
      );
}

final receptionist_workflowControllerProvider =
    StateNotifierProvider<
      ReceptionistWorkflowScreenController,
      ReceptionistWorkflowScreenState
    >((ref) {
      return ReceptionistWorkflowScreenController(ref);
    });
