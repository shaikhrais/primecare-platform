import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TerritoryExpansionManagerWorkflowScreenState
    extends DashboardState<TerritoryExpansionManagerWorkflowScreenState> {
  TerritoryExpansionManagerWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TerritoryExpansionManagerWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TerritoryExpansionManagerWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TerritoryExpansionManagerWorkflowScreenController
    extends
        BaseDashboardController<TerritoryExpansionManagerWorkflowScreenState> {
  TerritoryExpansionManagerWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: TerritoryExpansionManagerWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/territory-expansion-manager-workflow',
      );
}

final territory_expansion_manager_workflowControllerProvider =
    StateNotifierProvider<
      TerritoryExpansionManagerWorkflowScreenController,
      TerritoryExpansionManagerWorkflowScreenState
    >((ref) {
      return TerritoryExpansionManagerWorkflowScreenController(ref);
    });
