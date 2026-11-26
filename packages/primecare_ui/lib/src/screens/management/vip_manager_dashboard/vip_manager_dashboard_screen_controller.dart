import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VipManagerDashboardScreenState
    extends DashboardState<VipManagerDashboardScreenState> {
  VipManagerDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  VipManagerDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => VipManagerDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class VipManagerDashboardScreenController
    extends BaseDashboardController<VipManagerDashboardScreenState> {
  VipManagerDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: VipManagerDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/management/vip-manager-dashboard',
      );
}

final vip_manager_dashboardControllerProvider =
    StateNotifierProvider<
      VipManagerDashboardScreenController,
      VipManagerDashboardScreenState
    >((ref) {
      return VipManagerDashboardScreenController(ref);
    });
