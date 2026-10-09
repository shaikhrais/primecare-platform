import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScrumMasterWorkflowScreenState
    extends DashboardState<ScrumMasterWorkflowScreenState> {
  ScrumMasterWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ScrumMasterWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ScrumMasterWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ScrumMasterWorkflowScreenController
    extends BaseDashboardController<ScrumMasterWorkflowScreenState> {
  ScrumMasterWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: ScrumMasterWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/management/scrum-master-workflow',
      );
}

final scrum_master_workflowControllerProvider =
    StateNotifierProvider<
      ScrumMasterWorkflowScreenController,
      ScrumMasterWorkflowScreenState
    >((ref) {
      return ScrumMasterWorkflowScreenController(ref);
    });
