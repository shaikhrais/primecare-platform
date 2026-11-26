import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinanceDirectorDashboardScreenState
    extends DashboardState<FinanceDirectorDashboardScreenState> {
  FinanceDirectorDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FinanceDirectorDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FinanceDirectorDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FinanceDirectorDashboardScreenController
    extends BaseDashboardController<FinanceDirectorDashboardScreenState> {
  FinanceDirectorDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: FinanceDirectorDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/corporate/roles/finance_director/dashboard',
      );
}

final finance_director_dashboardControllerProvider =
    StateNotifierProvider<
      FinanceDirectorDashboardScreenController,
      FinanceDirectorDashboardScreenState
    >((ref) {
      return FinanceDirectorDashboardScreenController(ref);
    });
