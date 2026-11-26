import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadOfMarketingWorkflowScreenState
    extends DashboardState<HeadOfMarketingWorkflowScreenState> {
  HeadOfMarketingWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HeadOfMarketingWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HeadOfMarketingWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HeadOfMarketingWorkflowScreenController
    extends BaseDashboardController<HeadOfMarketingWorkflowScreenState> {
  HeadOfMarketingWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: HeadOfMarketingWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/head-of-marketing-workflow',
      );
}

final head_of_marketing_workflowControllerProvider =
    StateNotifierProvider<
      HeadOfMarketingWorkflowScreenController,
      HeadOfMarketingWorkflowScreenState
    >((ref) {
      return HeadOfMarketingWorkflowScreenController(ref);
    });
