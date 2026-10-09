import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CisoWorkflowScreenState extends DashboardState<CisoWorkflowScreenState> {
  CisoWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CisoWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CisoWorkflowScreenState(isLoading: isLoading, error: error, data: data);
}

class CisoWorkflowScreenController
    extends BaseDashboardController<CisoWorkflowScreenState> {
  CisoWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: CisoWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/executive/ciso-workflow',
      );
}

final ciso_workflowControllerProvider =
    StateNotifierProvider<
      CisoWorkflowScreenController,
      CisoWorkflowScreenState
    >((ref) {
      return CisoWorkflowScreenController(ref);
    });
