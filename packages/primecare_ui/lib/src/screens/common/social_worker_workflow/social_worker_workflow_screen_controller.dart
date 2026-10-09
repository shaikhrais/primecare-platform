import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SocialWorkerWorkflowScreenState
    extends DashboardState<SocialWorkerWorkflowScreenState> {
  SocialWorkerWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SocialWorkerWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SocialWorkerWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SocialWorkerWorkflowScreenController
    extends BaseDashboardController<SocialWorkerWorkflowScreenState> {
  SocialWorkerWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: SocialWorkerWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/social_worker/workflow',
      );
}

final social_worker_workflowControllerProvider =
    StateNotifierProvider<
      SocialWorkerWorkflowScreenController,
      SocialWorkerWorkflowScreenState
    >((ref) {
      return SocialWorkerWorkflowScreenController(ref);
    });
