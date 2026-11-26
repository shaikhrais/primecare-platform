import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GovernanceOfficerDashboardScreenState
    extends DashboardState<GovernanceOfficerDashboardScreenState> {
  GovernanceOfficerDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  GovernanceOfficerDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => GovernanceOfficerDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class GovernanceOfficerDashboardScreenController
    extends BaseDashboardController<GovernanceOfficerDashboardScreenState> {
  GovernanceOfficerDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: GovernanceOfficerDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/governance-officer-dashboard',
      );
}

final governance_officer_dashboardControllerProvider =
    StateNotifierProvider<
      GovernanceOfficerDashboardScreenController,
      GovernanceOfficerDashboardScreenState
    >((ref) {
      return GovernanceOfficerDashboardScreenController(ref);
    });
