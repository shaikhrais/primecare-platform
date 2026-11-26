import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnDashboardScreenState extends DashboardState<RpnDashboardScreenState> {
  RpnDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RpnDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RpnDashboardScreenState(isLoading: isLoading, error: error, data: data);
}

class RpnDashboardScreenController
    extends BaseDashboardController<RpnDashboardScreenState> {
  RpnDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: RpnDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rpn/dashboard',
      );
}

final rpn_dashboardControllerProvider =
    StateNotifierProvider<
      RpnDashboardScreenController,
      RpnDashboardScreenState
    >((ref) {
      return RpnDashboardScreenController(ref);
    });
