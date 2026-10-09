import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeDashboardScreenState
    extends DashboardState<IntakeDashboardScreenState> {
  IntakeDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  IntakeDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => IntakeDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class IntakeDashboardScreenController
    extends BaseDashboardController<IntakeDashboardScreenState> {
  IntakeDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: IntakeDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/intake_coordinator/dashboard-dup-1',
      );
}

final intake_dashboardControllerProvider =
    StateNotifierProvider<
      IntakeDashboardScreenController,
      IntakeDashboardScreenState
    >((ref) {
      return IntakeDashboardScreenController(ref);
    });
