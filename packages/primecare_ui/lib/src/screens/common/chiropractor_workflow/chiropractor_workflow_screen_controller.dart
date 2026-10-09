import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorWorkflowScreenState
    extends DashboardState<ChiropractorWorkflowScreenState> {
  ChiropractorWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ChiropractorWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ChiropractorWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ChiropractorWorkflowScreenController
    extends BaseDashboardController<ChiropractorWorkflowScreenState> {
  ChiropractorWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: ChiropractorWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/chiropractor/workflow',
      );
}

final chiropractor_workflowControllerProvider =
    StateNotifierProvider<
      ChiropractorWorkflowScreenController,
      ChiropractorWorkflowScreenState
    >((ref) {
      return ChiropractorWorkflowScreenController(ref);
    });
