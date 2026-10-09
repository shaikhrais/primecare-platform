import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorAnalyticsScreenState
    extends DashboardState<HrDirectorAnalyticsScreenState> {
  HrDirectorAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrDirectorAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrDirectorAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrDirectorAnalyticsScreenController
    extends BaseDashboardController<HrDirectorAnalyticsScreenState> {
  HrDirectorAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: HrDirectorAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/executive/hr-director-analytics',
      );
}

final hr_director_analyticsControllerProvider =
    StateNotifierProvider<
      HrDirectorAnalyticsScreenController,
      HrDirectorAnalyticsScreenState
    >((ref) {
      return HrDirectorAnalyticsScreenController(ref);
    });
