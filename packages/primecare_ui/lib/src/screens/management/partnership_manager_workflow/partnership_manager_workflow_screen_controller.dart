import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnershipManagerWorkflowScreenState
    extends DashboardState<PartnershipManagerWorkflowScreenState> {
  PartnershipManagerWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PartnershipManagerWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PartnershipManagerWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PartnershipManagerWorkflowScreenController
    extends BaseDashboardController<PartnershipManagerWorkflowScreenState> {
  PartnershipManagerWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: PartnershipManagerWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/partnership-manager-workflow',
      );
}

final partnership_manager_workflowControllerProvider =
    StateNotifierProvider<
      PartnershipManagerWorkflowScreenController,
      PartnershipManagerWorkflowScreenState
    >((ref) {
      return PartnershipManagerWorkflowScreenController(ref);
    });
