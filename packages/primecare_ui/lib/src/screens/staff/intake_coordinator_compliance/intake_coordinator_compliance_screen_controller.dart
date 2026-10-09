import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorComplianceScreenState
    extends DashboardState<IntakeCoordinatorComplianceScreenState> {
  IntakeCoordinatorComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  IntakeCoordinatorComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class IntakeCoordinatorComplianceScreenController
    extends BaseDashboardController<IntakeCoordinatorComplianceScreenState> {
  IntakeCoordinatorComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: IntakeCoordinatorComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint:
            '/offices/clinical/roles/intake_coordinator/coordinator-compliance',
      );
}

final intake_coordinator_complianceControllerProvider =
    StateNotifierProvider<
      IntakeCoordinatorComplianceScreenController,
      IntakeCoordinatorComplianceScreenState
    >((ref) {
      return IntakeCoordinatorComplianceScreenController(ref);
    });
