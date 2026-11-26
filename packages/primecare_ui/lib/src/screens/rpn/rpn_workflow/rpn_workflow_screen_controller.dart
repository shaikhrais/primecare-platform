import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnWorkflowScreenState extends DashboardState<RpnWorkflowScreenState> {
  RpnWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RpnWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RpnWorkflowScreenState(isLoading: isLoading, error: error, data: data);
}

class RpnWorkflowScreenController
    extends BaseDashboardController<RpnWorkflowScreenState> {
  RpnWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: RpnWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rpn/rpn-workflow',
      );
}

final rpn_workflowControllerProvider =
    StateNotifierProvider<RpnWorkflowScreenController, RpnWorkflowScreenState>((
      ref,
    ) {
      return RpnWorkflowScreenController(ref);
    });
