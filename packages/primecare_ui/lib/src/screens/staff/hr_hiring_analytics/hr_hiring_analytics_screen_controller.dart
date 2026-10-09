import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringAnalyticsScreenState
    extends DashboardState<HrHiringAnalyticsScreenState> {
  HrHiringAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrHiringAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrHiringAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrHiringAnalyticsScreenController
    extends BaseDashboardController<HrHiringAnalyticsScreenState> {
  HrHiringAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: HrHiringAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/staff/hr-hiring-analytics',
      );
}

final hr_hiring_analyticsControllerProvider =
    StateNotifierProvider<
      HrHiringAnalyticsScreenController,
      HrHiringAnalyticsScreenState
    >((ref) {
      return HrHiringAnalyticsScreenController(ref);
    });
