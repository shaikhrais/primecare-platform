import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OperationsManagerAnalyticsScreenState
    extends DashboardState<OperationsManagerAnalyticsScreenState> {
  OperationsManagerAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  OperationsManagerAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => OperationsManagerAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class OperationsManagerAnalyticsScreenController
    extends BaseDashboardController<OperationsManagerAnalyticsScreenState> {
  OperationsManagerAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: OperationsManagerAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/operations-manager-analytics',
      );
}

final operations_manager_analyticsControllerProvider =
    StateNotifierProvider<
      OperationsManagerAnalyticsScreenController,
      OperationsManagerAnalyticsScreenState
    >((ref) {
      return OperationsManagerAnalyticsScreenController(ref);
    });
