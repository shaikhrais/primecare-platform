import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalMarketingManagerWorkflowScreenState
    extends DashboardState<LocalMarketingManagerWorkflowScreenState> {
  LocalMarketingManagerWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  LocalMarketingManagerWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => LocalMarketingManagerWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class LocalMarketingManagerWorkflowScreenController
    extends BaseDashboardController<LocalMarketingManagerWorkflowScreenState> {
  LocalMarketingManagerWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: LocalMarketingManagerWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/local-marketing-manager-workflow',
      );
}

final local_marketing_manager_workflowControllerProvider =
    StateNotifierProvider<
      LocalMarketingManagerWorkflowScreenController,
      LocalMarketingManagerWorkflowScreenState
    >((ref) {
      return LocalMarketingManagerWorkflowScreenController(ref);
    });
