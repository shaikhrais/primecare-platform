import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeDashboardScreenState
    extends DashboardState<EmployeeDashboardScreenState> {
  EmployeeDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  EmployeeDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => EmployeeDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class EmployeeDashboardScreenController
    extends BaseDashboardController<EmployeeDashboardScreenState> {
  EmployeeDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: EmployeeDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/staff/employee-dashboard',
      );
}

final employee_dashboardControllerProvider =
    StateNotifierProvider<
      EmployeeDashboardScreenController,
      EmployeeDashboardScreenState
    >((ref) {
      return EmployeeDashboardScreenController(ref);
    });
