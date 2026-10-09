import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinanceDirectorAnalyticsScreenState
    extends DashboardState<FinanceDirectorAnalyticsScreenState> {
  FinanceDirectorAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FinanceDirectorAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FinanceDirectorAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FinanceDirectorAnalyticsScreenController
    extends BaseDashboardController<FinanceDirectorAnalyticsScreenState> {
  FinanceDirectorAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: FinanceDirectorAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/finance-director-analytics',
      );
}

final finance_director_analyticsControllerProvider =
    StateNotifierProvider<
      FinanceDirectorAnalyticsScreenController,
      FinanceDirectorAnalyticsScreenState
    >((ref) {
      return FinanceDirectorAnalyticsScreenController(ref);
    });
