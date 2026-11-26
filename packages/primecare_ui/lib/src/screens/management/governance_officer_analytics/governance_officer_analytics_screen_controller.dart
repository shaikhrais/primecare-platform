import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GovernanceOfficerAnalyticsScreenState
    extends DashboardState<GovernanceOfficerAnalyticsScreenState> {
  GovernanceOfficerAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  GovernanceOfficerAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => GovernanceOfficerAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class GovernanceOfficerAnalyticsScreenController
    extends BaseDashboardController<GovernanceOfficerAnalyticsScreenState> {
  GovernanceOfficerAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: GovernanceOfficerAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/governance-officer-analytics',
      );
}

final governance_officer_analyticsControllerProvider =
    StateNotifierProvider<
      GovernanceOfficerAnalyticsScreenController,
      GovernanceOfficerAnalyticsScreenState
    >((ref) {
      return GovernanceOfficerAnalyticsScreenController(ref);
    });
