import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinancialDashboardScreenState
    extends DashboardState<FinancialDashboardScreenState> {
  FinancialDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FinancialDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FinancialDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FinancialDashboardScreenController
    extends BaseDashboardController<FinancialDashboardScreenState> {
  FinancialDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: FinancialDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/executive/financial-dashboard',
      );
}

final financial_dashboardControllerProvider =
    StateNotifierProvider<
      FinancialDashboardScreenController,
      FinancialDashboardScreenState
    >((ref) {
      return FinancialDashboardScreenController(ref);
    });
