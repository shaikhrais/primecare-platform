import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PortalDashboardScreenState
    extends DashboardState<PortalDashboardScreenState> {
  PortalDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PortalDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PortalDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PortalDashboardScreenController
    extends BaseDashboardController<PortalDashboardScreenState> {
  PortalDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: PortalDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/common/portal-dashboard',
      );
}

final portal_dashboardControllerProvider =
    StateNotifierProvider<
      PortalDashboardScreenController,
      PortalDashboardScreenState
    >((ref) {
      return PortalDashboardScreenController(ref);
    });
