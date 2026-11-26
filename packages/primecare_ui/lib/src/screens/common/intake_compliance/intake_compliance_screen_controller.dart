import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeComplianceScreenState
    extends DashboardState<IntakeComplianceScreenState> {
  IntakeComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  IntakeComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => IntakeComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class IntakeComplianceScreenController
    extends BaseDashboardController<IntakeComplianceScreenState> {
  IntakeComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: IntakeComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/intake_coordinator/compliance',
      );
}

final intake_complianceControllerProvider =
    StateNotifierProvider<
      IntakeComplianceScreenController,
      IntakeComplianceScreenState
    >((ref) {
      return IntakeComplianceScreenController(ref);
    });
