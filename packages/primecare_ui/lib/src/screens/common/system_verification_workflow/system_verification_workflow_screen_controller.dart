import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SystemVerificationWorkflowScreenState
    extends DashboardState<SystemVerificationWorkflowScreenState> {
  SystemVerificationWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SystemVerificationWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SystemVerificationWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SystemVerificationWorkflowScreenController
    extends BaseDashboardController<SystemVerificationWorkflowScreenState> {
  SystemVerificationWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: SystemVerificationWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/system-verification-workflow',
      );
}

final system_verification_workflowControllerProvider =
    StateNotifierProvider<
      SystemVerificationWorkflowScreenController,
      SystemVerificationWorkflowScreenState
    >((ref) {
      return SystemVerificationWorkflowScreenController(ref);
    });
