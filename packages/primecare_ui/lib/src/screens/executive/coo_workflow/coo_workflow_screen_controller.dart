import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooWorkflowScreenState extends DashboardState<CooWorkflowScreenState> {
  CooWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CooWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CooWorkflowScreenState(isLoading: isLoading, error: error, data: data);
}

class CooWorkflowScreenController
    extends BaseDashboardController<CooWorkflowScreenState> {
  CooWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: CooWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/executive/coo-workflow',
      );
}

final coo_workflowControllerProvider =
    StateNotifierProvider<CooWorkflowScreenController, CooWorkflowScreenState>((
      ref,
    ) {
      return CooWorkflowScreenController(ref);
    });
