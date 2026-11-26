import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TerritorySalesManagerWorkflowScreenState
    extends DashboardState<TerritorySalesManagerWorkflowScreenState> {
  TerritorySalesManagerWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TerritorySalesManagerWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TerritorySalesManagerWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TerritorySalesManagerWorkflowScreenController
    extends BaseDashboardController<TerritorySalesManagerWorkflowScreenState> {
  TerritorySalesManagerWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: TerritorySalesManagerWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/territory-sales-manager-workflow',
      );
}

final territory_sales_manager_workflowControllerProvider =
    StateNotifierProvider<
      TerritorySalesManagerWorkflowScreenController,
      TerritorySalesManagerWorkflowScreenState
    >((ref) {
      return TerritorySalesManagerWorkflowScreenController(ref);
    });
