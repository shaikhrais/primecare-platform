import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShareholderWorkflowScreenState
    extends DashboardState<ShareholderWorkflowScreenState> {
  ShareholderWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ShareholderWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ShareholderWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ShareholderWorkflowScreenController
    extends BaseDashboardController<ShareholderWorkflowScreenState> {
  ShareholderWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: ShareholderWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/executive/shareholder-workflow',
      );
}

final shareholder_workflowControllerProvider =
    StateNotifierProvider<
      ShareholderWorkflowScreenController,
      ShareholderWorkflowScreenState
    >((ref) {
      return ShareholderWorkflowScreenController(ref);
    });
