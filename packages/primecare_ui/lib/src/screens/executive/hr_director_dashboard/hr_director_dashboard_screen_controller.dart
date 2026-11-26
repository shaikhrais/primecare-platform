import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorDashboardScreenState
    extends DashboardState<HrDirectorDashboardScreenState> {
  HrDirectorDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrDirectorDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrDirectorDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrDirectorDashboardScreenController
    extends BaseDashboardController<HrDirectorDashboardScreenState> {
  HrDirectorDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: HrDirectorDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/offices/corporate/roles/hr_director/dashboard',
      );
}

final hr_director_dashboardControllerProvider =
    StateNotifierProvider<
      HrDirectorDashboardScreenController,
      HrDirectorDashboardScreenState
    >((ref) {
      return HrDirectorDashboardScreenController(ref);
    });
