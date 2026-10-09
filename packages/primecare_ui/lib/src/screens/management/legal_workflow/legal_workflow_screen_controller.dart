import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LegalWorkflowScreenState
    extends DashboardState<LegalWorkflowScreenState> {
  LegalWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  LegalWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      LegalWorkflowScreenState(isLoading: isLoading, error: error, data: data);
}

class LegalWorkflowScreenController
    extends BaseDashboardController<LegalWorkflowScreenState> {
  LegalWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: LegalWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/executive/legal-workflow',
      );
}

final legal_workflowControllerProvider =
    StateNotifierProvider<
      LegalWorkflowScreenController,
      LegalWorkflowScreenState
    >((ref) {
      return LegalWorkflowScreenController(ref);
    });
