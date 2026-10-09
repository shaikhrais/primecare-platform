import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PortalAnalyticsScreenState
    extends DashboardState<PortalAnalyticsScreenState> {
  PortalAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PortalAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PortalAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PortalAnalyticsScreenController
    extends BaseDashboardController<PortalAnalyticsScreenState> {
  PortalAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: PortalAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/common/portal-analytics',
      );
}

final portal_analyticsControllerProvider =
    StateNotifierProvider<
      PortalAnalyticsScreenController,
      PortalAnalyticsScreenState
    >((ref) {
      return PortalAnalyticsScreenController(ref);
    });
