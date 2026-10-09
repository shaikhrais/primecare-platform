import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfrastructureAnalyticsScreenState
    extends DashboardState<InfrastructureAnalyticsScreenState> {
  InfrastructureAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  InfrastructureAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => InfrastructureAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class InfrastructureAnalyticsScreenController
    extends BaseDashboardController<InfrastructureAnalyticsScreenState> {
  InfrastructureAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: InfrastructureAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/infrastructure-analytics',
      );
}

final infrastructure_analyticsControllerProvider =
    StateNotifierProvider<
      InfrastructureAnalyticsScreenController,
      InfrastructureAnalyticsScreenState
    >((ref) {
      return InfrastructureAnalyticsScreenController(ref);
    });
