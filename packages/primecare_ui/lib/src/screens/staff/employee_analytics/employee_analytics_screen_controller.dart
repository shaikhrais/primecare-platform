import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeAnalyticsScreenState
    extends DashboardState<EmployeeAnalyticsScreenState> {
  EmployeeAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  EmployeeAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => EmployeeAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class EmployeeAnalyticsScreenController
    extends BaseDashboardController<EmployeeAnalyticsScreenState> {
  EmployeeAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: EmployeeAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/staff/employee-analytics',
      );
}

final employee_analyticsControllerProvider =
    StateNotifierProvider<
      EmployeeAnalyticsScreenController,
      EmployeeAnalyticsScreenState
    >((ref) {
      return EmployeeAnalyticsScreenController(ref);
    });
