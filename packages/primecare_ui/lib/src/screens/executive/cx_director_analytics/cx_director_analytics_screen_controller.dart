import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CxDirectorAnalyticsScreenState
    extends DashboardState<CxDirectorAnalyticsScreenState> {
  CxDirectorAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CxDirectorAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CxDirectorAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CxDirectorAnalyticsScreenController
    extends BaseDashboardController<CxDirectorAnalyticsScreenState> {
  CxDirectorAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: CxDirectorAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/executive/cx-director-analytics',
      );
}

final cx_director_analyticsControllerProvider =
    StateNotifierProvider<
      CxDirectorAnalyticsScreenController,
      CxDirectorAnalyticsScreenState
    >((ref) {
      return CxDirectorAnalyticsScreenController(ref);
    });
