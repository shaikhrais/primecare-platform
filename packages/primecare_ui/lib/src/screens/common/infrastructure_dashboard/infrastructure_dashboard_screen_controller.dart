import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfrastructureDashboardScreenState
    extends DashboardState<InfrastructureDashboardScreenState> {
  InfrastructureDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  InfrastructureDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => InfrastructureDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class InfrastructureDashboardScreenController
    extends BaseDashboardController<InfrastructureDashboardScreenState> {
  InfrastructureDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: InfrastructureDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/infrastructure-dashboard',
      );
}

final infrastructure_dashboardControllerProvider =
    StateNotifierProvider<
      InfrastructureDashboardScreenController,
      InfrastructureDashboardScreenState
    >((ref) {
      return InfrastructureDashboardScreenController(ref);
    });
