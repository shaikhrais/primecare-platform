import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinanceDirectorWorkflowScreenState
    extends DashboardState<FinanceDirectorWorkflowScreenState> {
  FinanceDirectorWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FinanceDirectorWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FinanceDirectorWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FinanceDirectorWorkflowScreenController
    extends BaseDashboardController<FinanceDirectorWorkflowScreenState> {
  FinanceDirectorWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: FinanceDirectorWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/finance-director-workflow',
      );
}

final finance_director_workflowControllerProvider =
    StateNotifierProvider<
      FinanceDirectorWorkflowScreenController,
      FinanceDirectorWorkflowScreenState
    >((ref) {
      return FinanceDirectorWorkflowScreenController(ref);
    });
