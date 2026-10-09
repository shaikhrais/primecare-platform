import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceOverviewScreenState
    extends DashboardState<ComplianceOverviewScreenState> {
  ComplianceOverviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ComplianceOverviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ComplianceOverviewScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ComplianceOverviewScreenController
    extends BaseDashboardController<ComplianceOverviewScreenState> {
  ComplianceOverviewScreenController(Ref ref)
    : super(
        ref,
        initialState: ComplianceOverviewScreenState(isLoading: true, data: {}),
        endpoint: '/executive/compliance-overview',
      );
}

final compliance_overviewControllerProvider =
    StateNotifierProvider<
      ComplianceOverviewScreenController,
      ComplianceOverviewScreenState
    >((ref) {
      return ComplianceOverviewScreenController(ref);
    });
