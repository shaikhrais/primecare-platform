import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CxDirectorDashboardScreenState
    extends DashboardState<CxDirectorDashboardScreenState> {
  CxDirectorDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CxDirectorDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CxDirectorDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CxDirectorDashboardScreenController
    extends BaseDashboardController<CxDirectorDashboardScreenState> {
  CxDirectorDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: CxDirectorDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/offices/corporate/roles/cx_director/dashboard',
      );
}

final cx_director_dashboardControllerProvider =
    StateNotifierProvider<
      CxDirectorDashboardScreenController,
      CxDirectorDashboardScreenState
    >((ref) {
      return CxDirectorDashboardScreenController(ref);
    });
