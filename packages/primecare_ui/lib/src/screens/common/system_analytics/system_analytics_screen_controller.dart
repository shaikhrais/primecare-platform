import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SystemAnalyticsScreenState
    extends DashboardState<SystemAnalyticsScreenState> {
  SystemAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SystemAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SystemAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SystemAnalyticsScreenController
    extends BaseDashboardController<SystemAnalyticsScreenState> {
  SystemAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: SystemAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/common/system-analytics',
      );
}

final system_analyticsControllerProvider =
    StateNotifierProvider<
      SystemAnalyticsScreenController,
      SystemAnalyticsScreenState
    >((ref) {
      return SystemAnalyticsScreenController(ref);
    });
