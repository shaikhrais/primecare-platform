import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VipClientManagerAnalyticsScreenState
    extends DashboardState<VipClientManagerAnalyticsScreenState> {
  VipClientManagerAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  VipClientManagerAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => VipClientManagerAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class VipClientManagerAnalyticsScreenController
    extends BaseDashboardController<VipClientManagerAnalyticsScreenState> {
  VipClientManagerAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: VipClientManagerAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/vip-manager-analytics',
      );
}

final vip_manager_analyticsControllerProvider =
    StateNotifierProvider<
      VipClientManagerAnalyticsScreenController,
      VipClientManagerAnalyticsScreenState
    >((ref) {
      return VipClientManagerAnalyticsScreenController(ref);
    });
