import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseWorkflowScreenState
    extends DashboardState<FranchiseWorkflowScreenState> {
  FranchiseWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseWorkflowScreenController
    extends BaseDashboardController<FranchiseWorkflowScreenState> {
  FranchiseWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/common/franchise-workflow',
      );
}

final franchise_workflowControllerProvider =
    StateNotifierProvider<
      FranchiseWorkflowScreenController,
      FranchiseWorkflowScreenState
    >((ref) {
      return FranchiseWorkflowScreenController(ref);
    });
