import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnWorkflowScreenState extends DashboardState<RnWorkflowScreenState> {
  RnWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RnWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RnWorkflowScreenState(isLoading: isLoading, error: error, data: data);
}

class RnWorkflowScreenController
    extends BaseDashboardController<RnWorkflowScreenState> {
  RnWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: RnWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rn/rn-workflow',
      );
}

final rn_workflowControllerProvider =
    StateNotifierProvider<RnWorkflowScreenController, RnWorkflowScreenState>((
      ref,
    ) {
      return RnWorkflowScreenController(ref);
    });
