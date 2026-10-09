import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusinessDevelopmentWorkflowScreenState
    extends DashboardState<BusinessDevelopmentWorkflowScreenState> {
  BusinessDevelopmentWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  BusinessDevelopmentWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => BusinessDevelopmentWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class BusinessDevelopmentWorkflowScreenController
    extends BaseDashboardController<BusinessDevelopmentWorkflowScreenState> {
  BusinessDevelopmentWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: BusinessDevelopmentWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/business-development-workflow',
      );
}

final business_development_workflowControllerProvider =
    StateNotifierProvider<
      BusinessDevelopmentWorkflowScreenController,
      BusinessDevelopmentWorkflowScreenState
    >((ref) {
      return BusinessDevelopmentWorkflowScreenController(ref);
    });
