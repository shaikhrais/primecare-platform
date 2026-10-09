import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceDashboardScreenState
    extends DashboardState<ComplianceDashboardScreenState> {
  ComplianceDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ComplianceDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ComplianceDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ComplianceDashboardScreenController
    extends BaseDashboardController<ComplianceDashboardScreenState> {
  ComplianceDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: ComplianceDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/management/compliance-dashboard',
      );
}

final compliance_dashboardControllerProvider =
    StateNotifierProvider<
      ComplianceDashboardScreenController,
      ComplianceDashboardScreenState
    >((ref) {
      return ComplianceDashboardScreenController(ref);
    });
