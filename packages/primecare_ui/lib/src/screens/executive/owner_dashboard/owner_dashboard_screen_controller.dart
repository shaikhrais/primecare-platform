import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OwnerDashboardScreenState
    extends DashboardState<OwnerDashboardScreenState> {
  OwnerDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  OwnerDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      OwnerDashboardScreenState(isLoading: isLoading, error: error, data: data);
}

class OwnerDashboardScreenController
    extends BaseDashboardController<OwnerDashboardScreenState> {
  OwnerDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: OwnerDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/offices/corporate/roles/owner/dashboard',
      );
}

final owner_dashboardControllerProvider =
    StateNotifierProvider<
      OwnerDashboardScreenController,
      OwnerDashboardScreenState
    >((ref) {
      return OwnerDashboardScreenController(ref);
    });
