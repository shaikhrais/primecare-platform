import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiHealthDashboardScreenState
    extends DashboardState<ApiHealthDashboardScreenState> {
  ApiHealthDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ApiHealthDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ApiHealthDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ApiHealthDashboardScreenController
    extends BaseDashboardController<ApiHealthDashboardScreenState> {
  ApiHealthDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: ApiHealthDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/common/api-health-dashboard',
      );
}

final api_health_dashboardControllerProvider =
    StateNotifierProvider<
      ApiHealthDashboardScreenController,
      ApiHealthDashboardScreenState
    >((ref) {
      return ApiHealthDashboardScreenController(ref);
    });
