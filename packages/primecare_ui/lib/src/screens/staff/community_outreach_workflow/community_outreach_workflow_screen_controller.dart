import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityOutreachWorkflowScreenState
    extends DashboardState<CommunityOutreachWorkflowScreenState> {
  CommunityOutreachWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CommunityOutreachWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CommunityOutreachWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CommunityOutreachWorkflowScreenController
    extends BaseDashboardController<CommunityOutreachWorkflowScreenState> {
  CommunityOutreachWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: CommunityOutreachWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/community-outreach-workflow',
      );
}

final community_outreach_workflowControllerProvider =
    StateNotifierProvider<
      CommunityOutreachWorkflowScreenController,
      CommunityOutreachWorkflowScreenState
    >((ref) {
      return CommunityOutreachWorkflowScreenController(ref);
    });
