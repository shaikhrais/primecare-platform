import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrManagerAnalyticsScreenState
    extends DashboardState<HrManagerAnalyticsScreenState> {
  HrManagerAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrManagerAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrManagerAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrManagerAnalyticsScreenController
    extends BaseDashboardController<HrManagerAnalyticsScreenState> {
  HrManagerAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: HrManagerAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/staff/hr-manager-analytics',
      );
}

final hr_manager_analyticsControllerProvider =
    StateNotifierProvider<
      HrManagerAnalyticsScreenController,
      HrManagerAnalyticsScreenState
    >((ref) {
      return HrManagerAnalyticsScreenController(ref);
    });
