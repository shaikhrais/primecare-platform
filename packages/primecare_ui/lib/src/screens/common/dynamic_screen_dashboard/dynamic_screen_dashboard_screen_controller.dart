import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicDashboardScreenState
    extends DashboardState<DynamicDashboardScreenState> {
  DynamicDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  DynamicDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => DynamicDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class DynamicDashboardScreenController
    extends BaseDashboardController<DynamicDashboardScreenState> {
  DynamicDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: DynamicDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/common/dynamic-dashboard',
      );
}

final dynamic_dashboardControllerProvider =
    StateNotifierProvider<
      DynamicDashboardScreenController,
      DynamicDashboardScreenState
    >((ref) {
      return DynamicDashboardScreenController(ref);
    });
