import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrManagerDashboardScreenState
    extends DashboardState<HrManagerDashboardScreenState> {
  HrManagerDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrManagerDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrManagerDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrManagerDashboardScreenController
    extends BaseDashboardController<HrManagerDashboardScreenState> {
  HrManagerDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: HrManagerDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/offices/corporate/roles/hr_manager/dashboard',
      );
}

final hr_manager_dashboardControllerProvider =
    StateNotifierProvider<
      HrManagerDashboardScreenController,
      HrManagerDashboardScreenState
    >((ref) {
      return HrManagerDashboardScreenController(ref);
    });
