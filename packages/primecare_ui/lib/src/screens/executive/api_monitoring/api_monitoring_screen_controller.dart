import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiMonitoringScreenState
    extends DashboardState<ApiMonitoringScreenState> {
  ApiMonitoringScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ApiMonitoringScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      ApiMonitoringScreenState(isLoading: isLoading, error: error, data: data);
}

class ApiMonitoringScreenController
    extends BaseDashboardController<ApiMonitoringScreenState> {
  ApiMonitoringScreenController(Ref ref)
    : super(
        ref,
        initialState: ApiMonitoringScreenState(isLoading: true, data: {}),
        endpoint: '/executive/api-monitoring',
      );
}

final api_monitoringControllerProvider =
    StateNotifierProvider<
      ApiMonitoringScreenController,
      ApiMonitoringScreenState
    >((ref) {
      return ApiMonitoringScreenController(ref);
    });
