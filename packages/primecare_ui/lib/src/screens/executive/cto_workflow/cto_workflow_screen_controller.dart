import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CtoWorkflowScreenState extends DashboardState<CtoWorkflowScreenState> {
  CtoWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CtoWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CtoWorkflowScreenState(isLoading: isLoading, error: error, data: data);
}

class CtoWorkflowScreenController
    extends BaseDashboardController<CtoWorkflowScreenState> {
  CtoWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: CtoWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/executive/cto-workflow',
      );
}

final cto_workflowControllerProvider =
    StateNotifierProvider<CtoWorkflowScreenController, CtoWorkflowScreenState>((
      ref,
    ) {
      return CtoWorkflowScreenController(ref);
    });
