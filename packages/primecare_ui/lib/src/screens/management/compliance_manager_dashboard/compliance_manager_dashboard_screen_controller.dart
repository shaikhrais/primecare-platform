import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceManagerDashboardScreenState
    extends DashboardState<ComplianceManagerDashboardScreenState> {
  ComplianceManagerDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ComplianceManagerDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ComplianceManagerDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ComplianceManagerDashboardScreenController
    extends BaseDashboardController<ComplianceManagerDashboardScreenState> {
  ComplianceManagerDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: ComplianceManagerDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/corporate/roles/compliance_manager/dashboard',
      );
}

final compliance_manager_dashboardControllerProvider =
    StateNotifierProvider<
      ComplianceManagerDashboardScreenController,
      ComplianceManagerDashboardScreenState
    >((ref) {
      return ComplianceManagerDashboardScreenController(ref);
    });
