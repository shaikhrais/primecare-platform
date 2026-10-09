import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalBdmWorkflowScreenState
    extends DashboardState<RegionalBdmWorkflowScreenState> {
  RegionalBdmWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RegionalBdmWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RegionalBdmWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RegionalBdmWorkflowScreenController
    extends BaseDashboardController<RegionalBdmWorkflowScreenState> {
  RegionalBdmWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: RegionalBdmWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/management/regional-bdm-workflow',
      );
}

final regional_bdm_workflowControllerProvider =
    StateNotifierProvider<
      RegionalBdmWorkflowScreenController,
      RegionalBdmWorkflowScreenState
    >((ref) {
      return RegionalBdmWorkflowScreenController(ref);
    });
