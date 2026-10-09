import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GovernanceOfficerComplianceScreenState
    extends DashboardState<GovernanceOfficerComplianceScreenState> {
  GovernanceOfficerComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  GovernanceOfficerComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => GovernanceOfficerComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class GovernanceOfficerComplianceScreenController
    extends BaseDashboardController<GovernanceOfficerComplianceScreenState> {
  GovernanceOfficerComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: GovernanceOfficerComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/governance-officer-compliance',
      );
}

final governance_officer_complianceControllerProvider =
    StateNotifierProvider<
      GovernanceOfficerComplianceScreenController,
      GovernanceOfficerComplianceScreenState
    >((ref) {
      return GovernanceOfficerComplianceScreenController(ref);
    });
