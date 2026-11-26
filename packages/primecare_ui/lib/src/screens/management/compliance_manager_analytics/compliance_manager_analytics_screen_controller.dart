import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceManagerAnalyticsScreenState
    extends DashboardState<ComplianceManagerAnalyticsScreenState> {
  ComplianceManagerAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ComplianceManagerAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ComplianceManagerAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ComplianceManagerAnalyticsScreenController
    extends BaseDashboardController<ComplianceManagerAnalyticsScreenState> {
  ComplianceManagerAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: ComplianceManagerAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/compliance-manager-analytics',
      );
}

final compliance_manager_analyticsControllerProvider =
    StateNotifierProvider<
      ComplianceManagerAnalyticsScreenController,
      ComplianceManagerAnalyticsScreenState
    >((ref) {
      return ComplianceManagerAnalyticsScreenController(ref);
    });
