import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalManagerUsaWorkflowScreenState
    extends DashboardState<RegionalManagerUsaWorkflowScreenState> {
  RegionalManagerUsaWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RegionalManagerUsaWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RegionalManagerUsaWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RegionalManagerUsaWorkflowScreenController
    extends BaseDashboardController<RegionalManagerUsaWorkflowScreenState> {
  RegionalManagerUsaWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: RegionalManagerUsaWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/regional-manager-usa-workflow',
      );
}

final regional_manager_usa_workflowControllerProvider =
    StateNotifierProvider<
      RegionalManagerUsaWorkflowScreenController,
      RegionalManagerUsaWorkflowScreenState
    >((ref) {
      return RegionalManagerUsaWorkflowScreenController(ref);
    });
