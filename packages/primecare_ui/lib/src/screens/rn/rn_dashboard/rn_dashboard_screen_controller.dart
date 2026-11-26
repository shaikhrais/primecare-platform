import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnDashboardScreenState extends DashboardState<RnDashboardScreenState> {
  RnDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RnDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RnDashboardScreenState(isLoading: isLoading, error: error, data: data);
}

class RnDashboardScreenController
    extends BaseDashboardController<RnDashboardScreenState> {
  RnDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: RnDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rn/dashboard',
      );
}

final rn_dashboardControllerProvider =
    StateNotifierProvider<RnDashboardScreenController, RnDashboardScreenState>((
      ref,
    ) {
      return RnDashboardScreenController(ref);
    });
