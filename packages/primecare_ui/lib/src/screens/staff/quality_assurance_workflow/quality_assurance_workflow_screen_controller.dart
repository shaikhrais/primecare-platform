import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QualityAssuranceWorkflowScreenState
    extends DashboardState<QualityAssuranceWorkflowScreenState> {
  QualityAssuranceWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  QualityAssuranceWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => QualityAssuranceWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class QualityAssuranceWorkflowScreenController
    extends BaseDashboardController<QualityAssuranceWorkflowScreenState> {
  QualityAssuranceWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: QualityAssuranceWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/quality-assurance-workflow',
      );
}

final quality_assurance_workflowControllerProvider =
    StateNotifierProvider<
      QualityAssuranceWorkflowScreenController,
      QualityAssuranceWorkflowScreenState
    >((ref) {
      return QualityAssuranceWorkflowScreenController(ref);
    });
